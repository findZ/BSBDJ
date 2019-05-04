//
//  BSHomeUserModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeUserModel: HandyJSON {
    var header : Array<String>?
    var relationship : String?
    var uid : String?
    var is_vip : Bool?
    var is_v : Bool?
    var room_url : String?
    var room_name : String?
    var room_role : String?
    var room_icon : String?
    var name : String?
    
    required init() {
        
    }
}
