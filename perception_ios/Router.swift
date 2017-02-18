//
//  Router.swift
//  perception_ios
//
//  Created by Harvin on 9/19/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
enum TodoRouter:  URLRequestConvertible {
    
    //static let baseURL = URL(string: "http://localhost:3000/api/v1")
    //static let baseURL = URL(string: "https://pitonisa.herokuapp.com/api")
    static let baseURL = URL(string: "http://localhost:8000/api")
    case Searches
    case Login(User)
    case SearchKey(String)
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Searches:
            return Alamofire.HTTPMethod.get
        case .Login:
            return Alamofire.HTTPMethod.post
        case .SearchKey:
            return Alamofire.HTTPMethod.post
        }
    }
    var route : (path: String, parameters: [String: AnyObject]?) {
        switch self {
        case .Searches:
            return ("/searches/",nil)
        case .Login(let user):
            return ("/auth/authorize", ["username": (user.getEmail() as AnyObject), "password": (user.getPassword() as AnyObject)])
        case .SearchKey(let key):
            return ("/popularize/", ["key": (key as AnyObject)])
        }
    }
    var url : URL! { return TodoRouter.baseURL?.appendingPathComponent(route.path) }
 
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        let auth_token = KeychainSwift().get("auth_token")
        if(auth_token != nil && auth_token != ""){
            request.setValue("Token \(auth_token!)" , forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue
        return try! Alamofire
            .URLEncoding()
            .encode(request, with: route.parameters)
        
    }
    
}
