//
//  BSPersonalAttentionModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/6/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON


class BSPersonalAttentionModel: HandyJSON {

    var id : String?
    var username : String?
    var sex : String?
    var introduction : String?
    var profile_image : String?
    var profile_image_large : String?
    var background_image : String?
    var follow_count : String?
    var fans_count : String?
    var is_vip : Bool?
    var follow_id : String?
    var relationship : String?
    
    required init() {
        
    }
}
