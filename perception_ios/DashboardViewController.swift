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
class DashboardViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableSearches: UITableView!
    @IBOutlet weak var lbWelcome: UILabel!
    var searches:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getSearches()
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
        let cell = UITableViewCell()
        cell.textLabel!.text  = self.searches[indexPath.row]
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
                        self.searches.append(values[index]["tag"].stringValue)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
