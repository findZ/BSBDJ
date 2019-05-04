//
//  BSHomeGifModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeGifModel: HandyJSON {

    var height : String?
    var width : String?
    var images : Array<String>?
    var gif_thumbnail : Array<String>?
    var download_url : Array<String>?
    
    required init() {
        
    }
}
