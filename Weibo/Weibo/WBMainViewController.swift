//
//  MainViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/26.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {
    
    private lazy var btn_compose: UIButton = {
        
        let btn_compose = UIButton()
        let width = SCREEN_WIDTH / 5
        let rect = CGRect(x: 0, y: 0, width: width, height: 50)
        
        btn_compose.frame = CGRectOffset(rect, width * 2, 0)
        btn_compose.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn_compose.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        btn_compose.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        btn_compose.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        btn_compose.addTarget(self, action: #selector(WBMainViewController.compose), forControlEvents: .TouchUpInside)
        
        return btn_compose
    
    }()
    
    // MARK: -
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.addSubview(btn_compose)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureChildViewControlelr()
        
    }
    
    // MARK - Actions
    
    @objc private func compose() {
        print("compose")
    }
    
    // MARK - Configure
    
    private func configureChildViewControlelr() {
        
        let homeViewController = UIStoryboard(name: "WBHome", bundle: nil).instantiateViewControllerWithIdentifier("WBHomeViewController") as! WBHomeViewController
        
        configureAddChildViewController(homeViewController, title: "首页", imageName: "tabbar_home")
        configureAddChildViewController(WBMessageViewController(), title: "消息", imageName: "tabbar_message_center")
        configureAddChildViewController(UIViewController(), title: "", imageName: "")
        configureAddChildViewController(WBDiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        configureAddChildViewController(WBProfileViewController(), title: "我的", imageName: "tabbar_profile")
        
        tabBar.tintColor = UIColor.orangeColor()
        
    }
    
    private func configureAddChildViewController(controller: UIViewController, title: String, imageName: String) {
        
        let nav = UINavigationController()
        
        controller.title = title
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: "\(imageName)_highlighted")
        
        nav.addChildViewController(controller)
        
        addChildViewController(nav)
        
        
    }
    
}
