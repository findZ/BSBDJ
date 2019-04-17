//
//  BSHomeSubModel.swift
//  BaiSi
//
//  Created by wzh on 2019/4/10.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import HandyJSON

class BSHomeSubModel : HandyJSON {

    var id : String?
    var type : String?
    var text : String?
    var user_id : String?
    var name : String?
    var screen_name : String?
    var profile_image : String?
    var created_at : String?
    var create_time : String?
    var passtime : String?
    var love : String?
    var hate : String?
    var comment : String?
    var repost : String?
    var bookmark : String?
    var bimageuri : String?
    var voiceuri : String?
    var voicetime : String?
    var voicelength : String?
    var status : String?
    var theme_id : String?
    var theme_name : String?
    var theme_type : String?
    var videouri : String?
    var videotime : String?
    var original_pid : String?
    var cache_version : String?
    var playcount : String?
    var playfcount : String?
    var cai : String?
    var top_cmt : Array<Any>?
    var weixin_url : String?
    var themes : Array<Any>?
    var image0 : String?
    var image1 : String?
    var image2 : String?
    var is_gif : String?
    var image_small : String?
    var cdn_img : String?
    var width : String?
    var height : String?
    var tag : String?
    var t : Int64?
    var ding : String?
    var favourite : String?
    
    //自定义字段
    var thumbnailImage : String?
    var avThumbnailImage : String?
    
    
    
    required init() {
        
    }
    
    
    func thumbnailImageUri()  {
        if type == "10" || type == "41" || type == "31"{

           thumbnailImage = image0?.replacingOccurrences(of: "http://wimg.spriteapp.cn", with: "http://wimg.spriteapp.cn/crop/150x200")
        }
    }
}
