//
//  DashboardViewController.swift
//  perception_ios
//
//  Created by Harvin Llanes on 9/29/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import UIKit
import KeychainSwift
class DashboardViewController: UIViewController {

    @IBOutlet weak var lbWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyChain = KeychainSwift()
        var key = keyChain.getData("username")
        lbWelcome.text = " Welcome  \(key)"
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
