//
//  BSUserProfileModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/4.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSUserProfileModel: HandyJSON {

    var profile_image : String?
    var tiezi_count : String?
    var sex : String?
    var manager : String?
    var orders_unsubscribe : Dictionary<String, Any>?
    var id : String?
    var fans_count : String?
    var profile_image_large : String?
    var introduction : String?
    var follow_count : String?
    var comment_count : String?
    var share_count : String?
    var username : String?
    var trade_ruler : String?
    var is_vip : Bool?
    var relationship : String?
    var room_name : String?
    var background_image : String?
    var v_desc : String?
    var phone : String?
    var birthday : String?
    var jie_v : String?
    var sina_v : String?
    var level : String?
    var experience : String?
    var credit : String?
    var trade_history : String?
    var total_cmt_like_count : String?
    var bookmark : String?
    var room_url : String?
    var praise_count : String?
    var room_role : String?
    var room_icon : String?
    
    
    required init() {
        
    }
}
