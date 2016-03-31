//
//  Statuses.swift
//  Weibo
//
//  Created by 郑国凯 on 16/3/30.
//  Copyright © 2016年 郑国凯. All rights reserved.
//

import Foundation
import Alamofire

class  Statuses: NSObject {
    
    
    
    
    
    var created_at: String! //	string	微博创建时间
    var id: Int = 0 //	int64	微博ID
    var mid: Int = 0 //	int64	微博MID
    var idstr: String! //	string	字符串型的微博ID
    var text: String! //	string	微博信息内容
    var source: String! //	string	微博来源
    var favorited: Bool = false //	boolean	是否已收藏，true：是，false：否
    var truncated: Bool = false //	boolean	是否被截断，true：是，false：否
    var in_reply_to_status_id: String! //	string	（暂未支持）回复ID
    var in_reply_to_user_id: String! //	string	（暂未支持）回复人UID
    var in_reply_to_screen_name: String! //	string	（暂未支持）回复人昵称
    var thumbnail_pic: String! //	string	缩略图片地址，没有时不返回此字段
    var bmiddle_pic: String! //	string	中等尺寸图片地址，没有时不返回此字段
    var original_pic: String! //	string	原始图片地址，没有时不返回此字段
//    var geo: String! //	object: String! //	地理信息字段 详细
    var user: User! //	object	微博作者的用户信息字段 详细
//    var retweeted_status: String! //	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
    var reposts_count: Int = 0 //	int	转发数
    var comments_count: Int = 0 //	int	评论数
    var attitudes_count: Int = 0 //	int	表态数
//    var visible: String! //	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
    var pic_ids: String! //	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
//    var ad: String! //	object array	微博流内的推广微博ID

    // MARK: - 
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if "user" == key {
            user = User(dict: value as! [String : AnyObject])
            return
        }
        
        super.setValue(value, forKey: key)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}