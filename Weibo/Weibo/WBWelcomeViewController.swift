//
//  WBWelcomeViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/30.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        
        let img_avatar = UIImageView(frame: CGRect(x: (SCREEN_WIDTH - 100) / 2, y: 150, width: 100, height: 100))
        let img_bg = UIImageView(frame: SCREEN_BOUNDS)
        let lab = UILabel()
        
        img_bg.image = UIImage(named: "ad_background")
        
        img_avatar.layer.cornerRadius = 50
        img_avatar.clipsToBounds = true
        img_avatar.contentMode = .ScaleAspectFill
        img_avatar.sd_setImageWithURL(NSURL(string: Defaults[.avatar_large]), placeholderImage: UIImage(named: "avatar_default_big"), options: .ContinueInBackground)
        img_avatar.alpha = 0.0
       
        lab.text = "欢迎回来"
        lab.sizeToFit()
        lab.center = CGPoint(x: SCREEN_WIDTH / 2, y: CGRectGetMaxY(img_avatar.frame) + 16)
        lab.alpha = 0.0
        lab.textColor = UIColor.darkGrayColor()
        
        view.addSubview(img_bg)
        view.addSubview(img_avatar)
        view.addSubview(lab)
        view.frame = SCREEN_BOUNDS
        
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            img_avatar.alpha = 1.0
            
        }) { (_) -> Void in
            
            // 文本动画
            UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                lab.alpha = 1.0
                }, completion: { (_) -> Void in
                    UIApplication.sharedApplication().keyWindow!.rootViewController = WBMainViewController()
            })
        }
        
    }
    
}
