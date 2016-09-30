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
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "perception.png")
        var imageView = UIImageView(frame: self.view.bounds)
        imageView.image = image
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
       
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
        let user = User(username: username, password: password)
         Alamofire.request(TodoRouter.Login(user))
         .responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                     let has_errors = JSON(value)["non_field_errors"].exists() || JSON(value)["password"].exists() || JSON(value)["username"].stringValue == ""
                    if !has_errors {
                        user.parse(json: value)
                        let dashboardController = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewControllerIdentifier") as? DashboardViewController
                        //dashboardController?.navigationController?.pushViewController(dashboardController!, animated: true)
                        self.present(dashboardController!, animated: true, completion: nil)
                    }
                    else {
                        let alertError = UIAlertController(title: "Login Failed", message: "Wrong username or password", preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel) { (action) in
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertError.addAction(cancelAction)
                        self.present(alertError, animated: true, completion: nil)
                    }
                }
            case .failure(let error):
                let alertFailre = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                alertFailre.addAction(cancelAction)
                self.present(alertFailre, animated: true, completion: nil)            }
          }
        
    }
}

