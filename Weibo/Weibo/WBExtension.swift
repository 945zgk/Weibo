//
//  WBExtension.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

extension UITableView {
    
}

extension UIBarButtonItem {
    
    class func createBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: "\(imageName)_highlighted"), forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
        
    }
    
}
