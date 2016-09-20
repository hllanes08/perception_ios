//
//  ViewController.swift
//  perception_ios
//
//  Created by Harvin on 9/19/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User(username: "", password: "", email: "" )
        Alamofire.request(TodoRouter.Login(user))
        .responseJSON { (response) in
            debugPrint(response)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

