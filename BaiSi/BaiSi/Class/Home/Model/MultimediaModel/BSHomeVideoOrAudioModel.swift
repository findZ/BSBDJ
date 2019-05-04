//
//  BSHomeVideoOrAudioModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeVideoOrAudioModel: HandyJSON {

    var playfcount : String?
    var height : String?
    var width : String?
    var video : Array<String>?
    var audio : Array<String>?
    var download : Array<String>?
    var duration : String?
    var playcount : String?
    var thumbnail : Array<String>?
    var thumbnail_small : Array<String>?
    
    required init() {
        
    }
}
