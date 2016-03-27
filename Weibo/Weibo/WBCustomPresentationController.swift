//
//  WBCustomPresentationController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBCustomPresentationController: UIPresentationController {
    
    var presentFrame = CGRectZero
    private lazy var view_corver: UIView = {
       //
        let view = UIView(frame: SCREEN_BOUNDS)
        let tap = UITapGestureRecognizer(target: self, action: #selector(WBCustomPresentationController.dismissSelf))
        
        view.backgroundColor = UIColor.clearColor()
        view.addGestureRecognizer(tap)
        
        return view
        
    }()

    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    override func containerViewWillLayoutSubviews() {
        
        // presentedView: 被展示的视图
        // containerView: 容器视图
        containerView?.insertSubview(view_corver, atIndex: 0)
        presentedView()?.frame = presentFrame == CGRectZero ? CGRect(x: 80, y: 64, width: SCREEN_WIDTH - 80 * 2, height: 300) : presentFrame
    
    }
    
    // MARK: - Actions
    
    @objc private func dismissSelf() {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
