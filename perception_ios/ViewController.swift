//
//  ViewController.swift
//  perception_ios
//
//  Created by Harvin on 9/19/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let user = User(username: "", password: "", email: "" )
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeUsername(_ sender: UITextField) {
        
    }

    @IBAction func onClickLogin(_ sender: AnyObject) {
        let username:String = txtUsername.text as String!
        let password:String = txtPassword.text as String!
        var user = User(username: username, password: password)
         Alamofire.request(TodoRouter.Login(user))
         .responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    user.parse(json: value)
                }
            case .failure(let error):
                print(error)
            }
          }
        
    }
}

