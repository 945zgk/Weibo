//
//  WBVisitorView.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {
    
    private lazy var imgv_icon: UIImageView = {
        return UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    }()
    
    private lazy var imgv_home: UIImageView = {
        return UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    }()
    
    private lazy var lab_message: UILabel = {
        
        let lab = UILabel()
        
        lab.text = ""
        lab.numberOfLines = 0
        
        return lab
        
    }()
    
    private lazy var btn_login: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("登录", forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        
        return btn
        
    }()
    
    private lazy var btn_register: UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("注册", forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        
        return btn
        
    }()
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgv_icon)
        addSubview(imgv_home)
        addSubview(lab_message)
        addSubview(btn_login)
        addSubview(btn_register)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK -

}
