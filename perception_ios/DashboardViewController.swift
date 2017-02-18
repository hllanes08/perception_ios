//
//  DashboardViewController.swift
//  perception_ios
//
//  Created by Harvin Llanes on 9/29/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift
import  SwiftyJSON
import FontAwesome
class DashboardViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableSearches: UITableView!
    @IBOutlet weak var lbWelcome: UILabel!
    var loading: UIOverlayView?
    var searches = [String:String]()
    let backgroundColor = UIColor(red: 28/255, green: 33/255, blue: 42/255, alpha: 1)
    let viewBackgroundColor = UIColor(red: 37/255, green: 46/255, blue: 62/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading = UIOverlayView(frame: self.view.frame)
        self.view.addSubview(loading!)
        getSearches()
        self.loading?.removeFromSuperview()
        self.tabBarItem.image = UIImage.fontAwesomeIcon(name: FontAwesome.search, textColor: UIColor.black , size: CGSize(width: 30, height: 30 ))
        self.view.backgroundColor = viewBackgroundColor
        tableSearches.backgroundColor = backgroundColor
        searchbar.delegate = self
        self.tableSearches.estimatedRowHeight = 68
        self.tableSearches.rowHeight = UITableViewAutomaticDimension
        self.tableSearches.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableSearches.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.layoutMargins = UIEdgeInsets(top: 15, left: 0,bottom:15, right: 0)
        cell.backgroundColor = backgroundColor
        cell.textLabel!.text  = Array(self.searches.keys)[indexPath.row].capitalized
        cell.textLabel?.backgroundColor = backgroundColor
        cell.textLabel?.textColor = UIColor.white
        let backgroundView = UIView()
        backgroundView.backgroundColor = viewBackgroundColor
        cell.selectedBackgroundView = backgroundView
        cell.detailTextLabel?.text = Array(self.searches.values)[indexPath.row  ]
        cell.detailTextLabel?.textColor = UIColor.white
        //Image
        let url = URL(string: "http://res.cloudinary.com/perception/image/upload/r_max,w_100,h_100/v1476825441/lion-03_ijiume.jpg")
        do{
            let imageData = try Data(contentsOf: url!)
            cell.imageView?.image = UIImage(data: imageData)
            cell.imageView?.frame = CGRect(x: 10, y: 10, width: 68, height: 68)
            cell.imageView?.backgroundColor = UIColor.clear
            cell.imageView?.layer.cornerRadius = 23
            cell.imageView?.clipsToBounds = true
        }
        catch let error{
            print(error)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func getSearches(){
        Alamofire.request(TodoRouter.Searches)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    let value = response.result.value
                    let values = JSON(value)
                    for index in 0...values.count {
                        if(values[index]["value"].stringValue != ""){
                          self.searches[(values[index]["tag"].stringValue)] = values[index]["value"].stringValue
                        }
                    }
                    self.refreshTable()
                case .failure(let error):
                    let alertFailre = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertFailre.addAction(cancelAction)
                    self.present(alertFailre, animated: true, completion: nil)
                }
            }
    }
    func refreshTable(){
        self.tableSearches.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.addSubview(self.loading!)
        Alamofire.request(TodoRouter.SearchKey(searchbar.text!))
        .responseJSON { (response) in
            switch response.result {
            case .success:
                 var tags =  JSON(response.result.value)
                 self.searches.removeAll()
                 for value in tags {
                    self.searches[value.1[0].stringValue] = value.1[1].stringValue
                }
                self.tableSearches.reloadData()
                self.loading?.removeFromSuperview()
            case .failure(let error):
                print(error)
                self.loading?.removeFromSuperview()
            }
        }
    }
    func dismissKeyboard(){
        self.searchbar.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
