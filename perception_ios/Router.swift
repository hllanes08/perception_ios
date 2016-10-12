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
    
    static let baseURL = URL(string: "http://pitonisa.herokuapp.com/api/v1")
    
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
            return Alamofire.HTTPMethod.get
        }
    }
    var route : (path: String, parameters: [String: AnyObject]?) {
        switch self {
        case .Searches:
            return ("/searches/",nil)
        case .Login(let user):
            return ("/sessions", ["session[email]": (user.getEmail() as AnyObject), "session[password]": (user.getPassword() as AnyObject)])
        case .SearchKey(let key):
            return ("/sites/1/popularize_by_key", ["key": (key as AnyObject)])
        }
    }
    var url : URL! { return TodoRouter.baseURL?.appendingPathComponent(route.path) }
 
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        let auth_token = KeychainSwift().get("auth_token")
        if(auth_token != nil){
            request.setValue(auth_token , forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue
        return try! Alamofire
            .URLEncoding()
            .encode(request, with: route.parameters)
        
    }
    
}
