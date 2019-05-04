//
//  BSHomeDataModelFrame.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeDataModelFrame: NSObject {
    var iconViewFrame : CGRect?
    var vipViewFrame : CGRect?
    var nameFrame : CGRect?
    var timeFrame : CGRect?
    var textLabelFrame : CGRect?
    var imageViewFrame : CGRect?
    var videoViewFrame : CGRect?
    var audioViewFrame : CGRect?
    var bottomBarFrame : CGRect?
    var bottomLineFrame : CGRect?
    
    var cellHeight : CGFloat = 0.0
    
    private let margin : CGFloat = 5
    
    var model : BSHomeDataModel? {
        didSet{
            
            iconViewFrame = CGRect.init(x: 10, y: 10, width: 35, height: 35)
            let nameWidht = Screen_width - iconViewFrame!.maxX - 35
            vipViewFrame = CGRect.init(x: iconViewFrame!.maxX-10, y: iconViewFrame!.maxY-10, width: 10, height: 10)
            nameFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: 10, width: nameWidht, height: 16)
            timeFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: 34, width: nameWidht, height: 11)
            
            let textWidth = Screen_width - 20
            
            var textHeight = (self.model?.text?.boundingRect(with: CGSize.init(width: textWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(size: 16.0)], context: nil).size.height)!
            if textHeight > 100 {
                textHeight = 160
            }
            textLabelFrame = CGRect.init(x: 10, y: iconViewFrame!.maxY + 5, width: textWidth, height: textHeight)
            
            var bottomBarY = textLabelFrame!.maxY + margin
            let Y = textLabelFrame!.maxY + margin
            
            switch self.model?.type {
            case "video"://视频
                videoViewFrame = CGRect.init(x: 10, y: Int(Y), width: self.model!.thumbnailWidth, height:200)
                bottomBarY = videoViewFrame!.maxY + margin
                break
            case "image"://图片
                imageViewFrame = CGRect.init(x: 10, y: Int(Y), width: self.model!.thumbnailWidth, height:self.model!.thumbnailWidth)
                bottomBarY = imageViewFrame!.maxY + margin
                break
            case "gif"://gif图片
                let imgWidth  = NSString.init(string: self.model!.gif!.width!).integerValue
                let imgHeight = NSString.init(string: self.model!.gif!.height!).integerValue
                imageViewFrame = CGRect.init(x: 10, y: Int(Y), width: imgWidth, height:imgHeight)
                bottomBarY = imageViewFrame!.maxY + margin
                break
            case "audio"://声音
                audioViewFrame = CGRect.init(x: 10, y: Y, width: textWidth, height:200)
                bottomBarY = audioViewFrame!.maxY + margin
                break
            case "text"://段子
                break
                
            default:
                break
            }
            bottomBarFrame = CGRect.init(x: 10, y: bottomBarY, width: textWidth, height:35)
            bottomLineFrame = CGRect.init(x: 0, y: bottomBarFrame!.maxY, width: Screen_width, height:10)
            cellHeight = bottomLineFrame!.maxY
            
        }
    }
}
