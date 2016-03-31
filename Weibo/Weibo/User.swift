//
//  User.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/30.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import Foundation

class User: NSObject {

    var id: Int = 0 //	int64	用户UID
    var idstr: String! //	string	字符串型的用户UID
    var screen_name: String! //	string	用户昵称
    var name: String! //	string	友好显示名称
    var province: Int = 0 //	int	用户所在省级ID
    var city: Int = 0 //	int	用户所在城市ID
    var location: String! //	string	用户所在地
//    var description: String! //	string	用户个人描述
    var url: String! //	string	用户博客地址
    var profile_image_url: String! //	string	用户头像地址（中图），50×50像素
    var profile_url: String! //	string: String! //	用户的微博统一URL地址
    var domain: String! //	string	用户的个性化域名
    var weihao: String! //	string	用户的微号
    var gender: String! //	string	性别，m：男、f：女、n：未知
    var followers_count: Int = 0 //	int	粉丝数
    var friends_count: Int = 0 //	int	关注数
    var statuses_count: Int = 0 //	int	微博数
    var favourites_count: Int = 0 //	int	收藏数
    var created_at: String! //	string	用户创建（注册）时间
    var following: Bool = false //	boolean	暂未支持
    var allow_all_act_msg: Bool = false //	boolean	是否允许所有人给我发私信，true：是，false：否
    var geo_enabled: Bool = false //	boolean	是否允许标识用户的地理位置，true：是，false：否
    var verified: Bool = false //	boolean	是否是微博认证用户，即加V用户，true：是，false：否
    var verified_type: AnyObject! // 用户的认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var remark: String! //	string	用户备注信息，只有在查询用户关系时才返回此字段
//    var status: Statuses! //	object	用户的最近一条微博信息字段 详细 
    var allow_all_comment: Bool = false //	boolean	是否允许所有人对我的微博进行评论，true：是，false：否
    var avatar_large: String! //	string	用户头像地址（大图），180×180像素
    var avatar_hd: String! //	string	用户头像地址（高清），高清头像原图
    var verified_reason: String! //	string	认证原因
    var follow_me: Bool = false //	boolean	该用户是否关注当前登录用户，true：是，false：否
    var online_status: Int = 0 //	int	用户的在线状态，0：不在线、1：在线
    var bi_followers_count: Int = 0 //	int	用户的互粉数
    var lang: String! //	string	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
    var mbrank: Int = -1 // 会员等级
    
    // MARK: -
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
}