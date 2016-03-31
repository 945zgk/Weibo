//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/27.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import UIKit
import Alamofire

class WBOAuthViewController: UIViewController, UIWebViewDelegate {
    
    private lazy var webView = UIWebView()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        getOAuth()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    private func getOAuth() {
        
        let url = "\(WB_API)/oauth2/authorize?client_id=\(APP_KEY)&redirect_uri=\(APP_REDIRECT_URI)"
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
        webView.loadRequest(request)
        webView.frame = view.bounds
        webView.delegate = self
        
        view.addSubview(webView)
        
    }
    
    // MARK: - fetch
    
    /// 获取授权
    private func fetchToken() {
        
        let params = ["client_id": APP_KEY, "client_secret": APP_SECRET, "grant_type": "authorization_code", "code": Defaults[.APP_TOKEN], "redirect_uri": APP_REDIRECT_URI]
        
        Alamofire.request(.POST, "\(WB_API)/oauth2/access_token", parameters: params)
            .responseJSON { [weak self] response in
                
                guard self != nil  else { return }
                
                switch response.result {
                    
                case .Success:
                    
                    if let JSON = response.result.value {
                        
                        if let _ = JSON["error"] as? String {
                            print("fetchToken--error--\(JSON)")
                        }
                        
                        if let access_token = JSON["access_token"] as? String,
                            uid = JSON["uid"],
                            time = JSON["expires_in"] {
                            
                            Defaults[.access_token] = access_token
                            Defaults[.uid] = (uid?.integerValue)!
                            Defaults[.expires_in] = (time?.integerValue)!
                            
                            self!.fetchUserInfo()
                            
                        }
                        
                    }
                    
                case .Failure:
                    tips.showTipsInMainThread(Text: "授权失败")
                }
                
        }
        
    }
    
    /// 获取用户信息
    
    private func fetchUserInfo() {
        
        let params = ["access_token": Defaults[.access_token], "uid": Defaults[.uid]]
        
        Alamofire.request(.GET, "\(WB_API)/2/users/show.json", parameters: params as? [String : AnyObject])
            
            .responseJSON { [weak self] response in
                
                guard self != nil  else { return }
                
                switch response.result {
                    
                case .Success:
                    
                    if let JSON = response.result.value {
                        
                        if let _ = JSON["error"] as? String {
                            print("fetchUserInfo--error--\(JSON)")
                        }
                        
                        if let avatar_large = JSON["avatar_large"] as? String,
                            screen_name = JSON["screen_name"] as? String {
                            
                            Defaults[.avatar_large] = avatar_large
                            Defaults[.screen_name] = screen_name
                            
                            UIApplication.sharedApplication().keyWindow?.rootViewController = WBMainViewController()
                        }
                        
                    }
                    
                case .Failure:
                    tips.showTipsInMainThread(Text: "授权失败")
                }
                
        }
        
    }
    
    // MARK: - UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.URL)
        
        if let url = request.URL {
            if url.absoluteString.hasPrefix(APP_REDIRECT_URI) {
                
                let code = url.absoluteString.substringFromIndex("\(APP_REDIRECT_URI)?code==".endIndex)
                
                    Defaults[.APP_TOKEN] = code
                    fetchToken()
                    return false
                
            }
        }
        return true
    }
}