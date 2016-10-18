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
        self.backgroundColor = UIColor(red: 37/255, green: 46/255, blue: 62/255, alpha: 0)
        self.scrollView.backgroundColor = UIColor(red: 37/255, green: 46/255, blue: 62/255, alpha: 0.5)
        self.isOpaque = false
        self.scrollView.isOpaque = false
        self.frame = UIScreen.main.bounds
        let insets = UIEdgeInsets(top: self.frame.height/4, left: 0,bottom:0, right: 0)
        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
}
