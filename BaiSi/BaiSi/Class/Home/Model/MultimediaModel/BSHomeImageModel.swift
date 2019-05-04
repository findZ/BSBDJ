//
//  BSHomeImageModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeImageModel: HandyJSON {
    var medium : Array<String>?
    var big : Array<String>?
    var download_url : Array<String>?
    var height : Float?
    var width : Float?
    var small : Array<String>?
    var thumbnail_small : Array<String>?
    
    required init() {
        
    }
}
