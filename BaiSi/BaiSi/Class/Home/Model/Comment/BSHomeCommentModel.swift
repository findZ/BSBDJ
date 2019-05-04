//
//  BSHomeCommentModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeCommentModel: HandyJSON {

    var status : String?
    var ctime : String?
    var hate_count : String?
    var data_id : String?
    var video_signs : String?
    var children : Array<Any>?
    var content : String?
    var like_count : String?
    var user : BSHomeCommentUserModel?
    var vote : Array<Any>?
    var precmts : Array<Any>?
    var type : String?
    var id : String?
    var more : Any?
    
    required init() {
        
    }
}
