//
//  User.swift
//  perception_ios
//
//  Created by Harvin on 9/19/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    private var username :String
    private var password :String
    private var email :String
    private var auht_token :String
    init(username:String, password: String, email: String){
        self.username  = username
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
}
