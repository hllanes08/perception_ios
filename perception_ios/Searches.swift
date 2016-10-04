//
//  Searches.swift
//  perception_ios
//
//  Created by Harvin on 10/4/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import KeychainSwift

class Searches {
    private var tag :String
    private var search_date: Date
    init(tag:String, search_date: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd "
        self.tag = tag
        self.search_date = formatter.date(from: search_date)!
    }
    
}
