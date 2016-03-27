//
//  WBTitleButton.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("好友圈 ", forState: .Normal)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 这个方法会调用两次
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let titleLabel = titleLabel,
            let imageView = imageView {
            
            titleLabel.frame.origin.x = 0
            imageView.frame.origin.x = titleLabel.frame.width
            
        }
        
    }
    
}
