//
//  BSHomeSubFrameModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/4/11.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeSubFrameModel: NSObject {
    var iconViewFrame : CGRect?
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
    
    var model : BSHomeSubModel? {
        didSet{
            
            iconViewFrame = CGRect.init(x: 10, y: 10, width: 35, height: 35)
            let nameWidht = Screen_width - iconViewFrame!.maxX - 35
            
            nameFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: 10, width: nameWidht, height: 16)
            timeFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: 34, width: nameWidht, height: 11)
            
            let textWidth = Screen_width - 20
            
            let textHeight = (self.model?.text?.boundingRect(with: CGSize.init(width: textWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(size: 16.0)], context: nil).size.height)! + 10.0
            
            textLabelFrame = CGRect.init(x: 10, y: iconViewFrame!.maxY + 5, width: textWidth, height: textHeight)
            
            var bottomBarY = textLabelFrame!.maxY + margin
            let Y = textLabelFrame!.maxY + margin

            switch self.model?.type {
            case "41"://视频
                videoViewFrame = CGRect.init(x: 10, y: Int(Y), width: self.model!.thumbnailWidth, height:200)
                bottomBarY = videoViewFrame!.maxY + margin
                break
            case "10"://图片
                imageViewFrame = CGRect.init(x: 10, y: Int(Y), width: self.model!.thumbnailWidth, height:self.model!.thumbnailHeight!)
                bottomBarY = imageViewFrame!.maxY + margin
                break
            case "31"://声音
                audioViewFrame = CGRect.init(x: 10, y: Y, width: 300, height:100)
                bottomBarY = audioViewFrame!.maxY + margin
                break
            case "29"://段子
                break
                
            default:
                break
            }
            bottomBarFrame = CGRect.init(x: 10, y: bottomBarY, width: textWidth, height:0)
            bottomLineFrame = CGRect.init(x: 0, y: bottomBarFrame!.maxY, width: Screen_width, height:10)
            cellHeight = bottomLineFrame!.maxY
            
        }
    }
    
    
}
