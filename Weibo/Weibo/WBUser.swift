//
//  WBUser.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/27.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import Foundation

class DefaultsKey<ValueType>: WBUser {
    
    let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
}

class WBUser {}

extension WBUser {
    
    // MARK: - 用来请求授权
    static let APP_TOKEN = DefaultsKey<String>("APP_TOKEN")
    
    // MARK: - 授权成功返回数据
    static let expires_in = DefaultsKey<Int>("user_expires_in")
    static let uid = DefaultsKey<Int>("user_uid")
    static let access_token = DefaultsKey<String>("user_access_token")

    // MARK: - 用户信息
    static let screen_name = DefaultsKey<String>("screen_name") // 名字
    static let avatar_large = DefaultsKey<String>("avatar_large")
    
    // MARK: - 首次登录
    static let first_login = DefaultsKey<Bool>("first_login")
    
}