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
    var textLabelFrame : CGRect?
    var imageViewFrame : CGRect?
    var bottomBarFrame : CGRect?
    var bottomLineFrame : CGRect?

    var cellHeight : CGFloat = 0.0
    
    private let margin : CGFloat = 5
    
    var model : BSHomeSubModel? {
        didSet{
            
            iconViewFrame = CGRect.init(x: 10, y: 10, width: 35, height: 35)
            let nameWidht = Screen_width - iconViewFrame!.maxX - 35
            
            nameFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: 15, width: nameWidht, height: 20)
            
            let textWidth = Screen_width - 20
            
            let textHeight = self.model?.text?.boundingRect(with: CGSize.init(width: textWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20.0)], context: nil).size.height
            
            textLabelFrame = CGRect.init(x: 10, y: iconViewFrame!.maxY + 5, width: textWidth, height: textHeight ?? 20)
            
            var bottomBarY = textLabelFrame!.maxY + margin
            if self.model?.type != "29"{
                let imgY = textLabelFrame!.maxY + margin
                
                imageViewFrame = CGRect.init(x: 10, y: imgY, width: 150, height:200)
                bottomBarY = imageViewFrame!.maxY + margin
            }
            bottomBarFrame = CGRect.init(x: 10, y: bottomBarY, width: textWidth, height:35)
            bottomLineFrame = CGRect.init(x: 0, y: bottomBarFrame!.maxY, width: Screen_width, height:10)
            cellHeight = bottomLineFrame!.maxY
            
        }
    }
    
    
}
