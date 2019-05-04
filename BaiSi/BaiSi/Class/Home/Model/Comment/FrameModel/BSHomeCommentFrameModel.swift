//
//  BSHomeCommentFrameModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeCommentFrameModel: NSObject {
    var iconViewFrame : CGRect?
    var vipViewFrame : CGRect?
    var nameLabelFrame : CGRect?
    var contentLabelFrame : CGRect?
    var timeLabelFrame : CGRect?
    var lineFrame : CGRect?
    
    var cellHeight : CGFloat = 0.0
    
    private let margin : CGFloat = 10
    
    var model : BSHomeCommentModel? {
        didSet{
            iconViewFrame = CGRect.init(x: margin, y: margin, width: 35, height: 35)
            let nameWidht = Screen_width - iconViewFrame!.maxX - 35
            vipViewFrame = CGRect.init(x: iconViewFrame!.maxX-10, y: iconViewFrame!.maxY-10, width: 10, height: 10)

            nameLabelFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: margin, width: nameWidht, height: 20)
            
            let textWidth = Screen_width - margin * 2 - iconViewFrame!.maxX
            
            let textHeight = (self.model?.content?.boundingRect(with: CGSize.init(width: textWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(size: 15.0)], context: nil).size.height)!
            
            contentLabelFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: nameLabelFrame!.maxY + margin/2, width: textWidth, height: textHeight)
            timeLabelFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: contentLabelFrame!.maxY + margin, width: textWidth, height: 10)
            let lineWidth = Screen_width - margin - iconViewFrame!.maxX
            lineFrame = CGRect.init(x: iconViewFrame!.maxX + margin, y: timeLabelFrame!.maxY + margin, width: lineWidth, height: 1)
            self.cellHeight = lineFrame!.maxY
        }
    }
}
