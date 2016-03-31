//
//  WBWelcomeViewCell.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/30.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBNewFeatureViewCell: UICollectionViewCell {
    
    private lazy var imgv = UIImageView()
    var index: Int! {
        didSet {
            imgv.image = UIImage(named: "new_feature_\(index + 1)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImage()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func gotoMain() {
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = WBMainViewController()
        
    }
    
    // MARK: - Configure
    
    func configureButton() {
        
        let btn = UIButton(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 100, width: SCREEN_WIDTH, height: 42))
            
        btn.setImage(UIImage(named: "new_feature_button"), forState: .Normal)
        btn.setImage(UIImage(named: "new_feature_button_highlighted"), forState: .Highlighted)
        btn.addTarget(self, action: #selector(WBNewFeatureViewCell.gotoMain), forControlEvents: .TouchUpInside)
        btn.hidden = true
        btn.transform = CGAffineTransformMakeScale(0, 0)
        
        contentView.addSubview(btn)
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .CurveLinear, animations: { 
            btn.transform = CGAffineTransformIdentity
            btn.hidden = false
            }) { (_) in        }
        
    }
    
    private func configureImage() {
        
        imgv.frame = SCREEN_BOUNDS
        
        contentView.addSubview(imgv)
        
    }
    
}
