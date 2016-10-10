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
    var overlay: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "perception.png")
        var imageView = UIImageView(frame: self.view.bounds)
        var bottomLineUsername = CALayer()
        var bottomLinePassword = CALayer()
        
        bottomLineUsername.frame = CGRect(x: 0.0, y: txtUsername.frame.height - 1, width: txtUsername.frame.width, height: 1)
        bottomLineUsername.backgroundColor = UIColor.white.cgColor
        
        bottomLinePassword.frame = CGRect(x: 0.0, y: txtPassword.frame.height - 1, width: txtPassword.frame.width, height: 1)
        bottomLinePassword.backgroundColor = UIColor.white.cgColor
        
        txtUsername.backgroundColor = UIColor(white: 1, alpha: 0)
        txtUsername.layer.addSublayer(bottomLineUsername)
        txtPassword.backgroundColor = UIColor(white: 1, alpha: 0)
        txtPassword.layer.addSublayer(bottomLinePassword)
        imageView.image = image
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
       
    }
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeUsername(_ sender: UITextField) {
        
    }

    @IBAction func onClickLogin(_ sender: AnyObject) {
        let email:String = txtUsername.text as String!
        let password:String = txtPassword.text as String!
        let user = User(email: email, password: password)
        if(email.isEmpty || password.isEmpty){
            let alertEmpty = UIAlertController(title: "Error", message: "User or Password are required", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertEmpty.addAction(cancelAction)
            self.present(alertEmpty, animated: true, completion: nil)

        }
        else{
        view.addSubview(self.overlay!)
        
         Alamofire.request(TodoRouter.Login(user))
         .responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let has_errors = JSON(value)["errors"].exists()
                    if !has_errors {
                        user.parse(json: value)
                        let tabController = self.storyboard?.instantiateViewController(withIdentifier: "UITabBarControllerIndetifier") as? UITabBarController
                        
                        tabController?.selectedIndex = 0
                        
                        
                        //dashboardController?.navigationController?.pushViewController(dashboardController!, animated: true)
                        self.present(tabController!, animated: true, completion: nil)
                    }
                    else {
                        let alertError = UIAlertController(title: "Login Failed", message: "Wrong email or password", preferredStyle: UIAlertControllerStyle.alert)
                        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel) { (action) in
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertError.addAction(cancelAction)
                        self.present(alertError, animated: true, completion: nil)
                    }
                }
                self.overlay!.removeFromSuperview()
            case .failure(let error):
                let alertFailre = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertActionStyle.cancel) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                alertFailre.addAction(cancelAction)
                self.present(alertFailre, animated: true, completion: nil)
                self.overlay!.removeFromSuperview()
            }
          }
        }
        
    }
}

