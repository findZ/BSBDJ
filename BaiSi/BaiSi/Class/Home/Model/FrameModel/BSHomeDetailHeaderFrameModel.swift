//
//  BSHomeDetailHeaderFrameModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeDetailHeaderFrameModel: NSObject {
    var contentLabelFrame : CGRect?
    var contentViewFrame : CGRect?
    var bottomBarFrame : CGRect?
    var bottomLineFrame : CGRect?
    
    var height : CGFloat?
    
    
    var model : BSHomeDataModel? {
        didSet {
            let textWidth = Screen_width - 20
            
            let textHeight = (self.model?.text?.boundingRect(with: CGSize.init(width: textWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(size: 16.0)], context: nil).size.height)!
            contentLabelFrame = CGRect.init(x: 10, y: 10, width: textWidth, height: textHeight)

            var width : Int = Int(Screen_width)
            var height : Int = 200
            switch self.model?.type {
            case "video"://视频
                height = 300
                break
            case "image"://图片
                let imgWidth  = self.model!.image!.width!
                let imgHeight = self.model!.image!.height!
                if imgWidth != 0 && imgHeight != 0 {
                    height = Int(Float(Screen_width) / (imgWidth/imgHeight))
                    width = Int(Float(Screen_width))
                }
                
                break
            case "gif"://gif图片
                let imgWidth  = NSString.init(string: self.model!.gif!.width!).floatValue
                let imgHeight = NSString.init(string: self.model!.gif!.height!).floatValue
                height = Int(Float(Screen_width) / (imgWidth/imgHeight))
                width = Int(Float(Screen_width))
                
                break
            case "audio"://声音
                height = 200
                break
            case "text"://段子
                height = 0
                break
            default:
                break
            }
            
            contentViewFrame = CGRect.init(x: 0, y: Int(contentLabelFrame!.maxY + 10), width: Int(width), height: Int(height))
            bottomBarFrame = CGRect.init(x: 10, y: contentViewFrame!.maxY, width: textWidth, height:35)

            bottomLineFrame = CGRect.init(x: 0, y: Int(bottomBarFrame!.maxY), width: Int(width), height: Int(20))
            self.height = bottomLineFrame?.maxY

        }
    }
}
