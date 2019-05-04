//
//  BSHomeDataModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeDataModel: HandyJSON {
    var status : String?
    var rating : String?
    var cate : String?
    var tags : Array<Dictionary<String, Any>>?
    var bookmark : String?
    var text : String?
    var is_best : String?
    var video_signs : String?
    var share_url : String?
    var up : String?
    var down : String?
    var forward : String?
    var u : BSHomeUserModel?
    var passtime : String?
    var audio : BSHomeVideoOrAudioModel?
    var image : BSHomeImageModel?
    var video : BSHomeVideoOrAudioModel?
    var gif : BSHomeGifModel?
    var type : String?
    var id : String?
    var comment : String?
    
    //自定义字段
    var thumbnailImage : String?
    var thumbnailWidth = Int(Screen_width - 20)
    var thumbnailHeight : Int?
    var isPlayAudio : Bool?
    
    required init() {
        
    }
    
}
