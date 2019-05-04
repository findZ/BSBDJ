//
//  BSHomeCommentUserModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeCommentUserModel: HandyJSON {

    var username : String?
    var qq_uid : String?
    var profile_image : String?
    var weibo_uid : String?
    var personal_page : String?
    var room_name : String?
    var room_role : String?
    var total_cmt_like_count : String?
    var is_vip : Bool?
    var room_url : String?
    var qzone_uid : String?
    var sex : String?
    var id : String?
    var room_icon : String?

    required init() {
        
    }
}
