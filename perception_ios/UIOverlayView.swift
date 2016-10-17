//
//  UIOverlayView.swift
//  perception_ios
//
//  Created by Harvin on 10/17/16.
//  Copyright © 2016 Harvin. All rights reserved.
//

import UIKit

class UIOverlayView: UIWebView {

    override init(frame: CGRect){
        super.init(frame: frame)
        let url = Bundle.main.url(forResource: "loading", withExtension: "gif")
        do{
            let gif = try Data(contentsOf: url!)
            self.load(gif, mimeType: "image/gif", textEncodingName: String(), baseURL: url!)
            self.isUserInteractionEnabled = false
        }
        catch let error{
            print(error)
        }
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
}
