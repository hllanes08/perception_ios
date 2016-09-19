//
//  Router.swift
//  perception_ios
//
//  Created by Harvin on 9/19/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import Foundation
import Alamofire

enum TodoRouter:  URLRequestConvertible {
    
    static let baseURL = URL(string: "http://localhost:8100/api")
    
    case Items
    case Login(user)
    
    var route : (path: String, parameters: [String: AnyObject]?) {
        switch self {
        case .Items:
            return ("/items/",nil)
        case .Login(User):
            return ("auth/authorize/", ["username": User.name, "password": User.password])
        }
    }
    var url : URL! { return TodoRouter.baseURL?.appendingPathComponent(route.path) }
 
    func asURLRequest() throws -> URLRequest {
       
        return try! Alamofire
            .URLEncoding()
            .encode(URLRequest(url: url), with: route.parameters)
        
    }
    
}
