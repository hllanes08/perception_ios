//
//  User.swift
//  perception_ios
//
//  Created by Harvin on 9/19/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import KeychainSwift

class User {
    
    private var username :String
    private var password :String
    private var email :String
    private var auht_token :String
    init(email:String, password: String){
        self.username  = ""
        self.password = password
        self.email = email
        self.auht_token = ""
    }
    func setToken(auth_token:String){
        self.auht_token = auth_token
    }
    func getAuthToken() -> String {
        return self.auht_token
    }
    func getUserName() -> String {
        return self.username
    }
    func getEmail() -> String {
        return self.email
    }
    func getPassword() -> String {
        return self.password
    }
    func parse(json: Any? ){
        let values = JSON(json)
        self.auht_token = values["user"]["auth_token"].stringValue
        let keyChain = KeychainSwift()
        keyChain.set(self.auht_token, forKey: "auth_token")
        //keyChain.set(values["username"].stringValue, forKey: "username")


    }
}
