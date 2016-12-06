//
//  PopularizeViewController.swift
//  perception_ios
//
//  Created by Harvin on 10/4/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import UIKit
import FontAwesome
class PopularizeViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let backgroundColor = UIColor(red: 28/255, green: 33/255, blue: 42/255, alpha: 1)
    let viewBackgroundColor = UIColor(red: 37/255, green: 46/255, blue: 62/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = viewBackgroundColor
        self.tabBarItem.image = UIImage.fontAwesomeIcon(name: FontAwesome.fire, textColor: UIColor.black , size: CGSize(width: 30, height: 30 ))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
