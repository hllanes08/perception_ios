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
    case Login(User)
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Items:
            return Alamofire.HTTPMethod.get
        case .Login:
            return Alamofire.HTTPMethod.post
        }
    }
    var route : (path: String, parameters: [String: AnyObject]?) {
        switch self {
        case .Items:
            return ("/items/",nil)
        case .Login(let user):
            return ("auth/authorize/", ["username": (user.getUserName() as AnyObject), "password": (user.getPassword() as AnyObject)])
        }
    }
    var url : URL! { return TodoRouter.baseURL?.appendingPathComponent(route.path) }
 
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return try! Alamofire
            .URLEncoding()
            .encode(request, with: route.parameters)
        
    }
    
}
