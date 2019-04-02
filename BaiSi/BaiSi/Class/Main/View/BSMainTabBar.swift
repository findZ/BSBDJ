//
//  BSMainTabBar.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSMainTabBar: UITabBar {
    
    lazy var publishButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 40, height: 40))
        btn.setImage(UIImage.init(named: "publish_icon_select"), for: UIControl.State.highlighted)
        btn.setImage(UIImage.init(named: "publish_icon"), for: UIControl.State.normal)
        btn.center = CGPoint.init(x: Screen_width/2, y: 40/2)

        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.publishButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        DLog(message: self.subviews)
        /*
        var array = Array<UIControl>()
        
        for subView in self.subviews {
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                array.append(subView as! UIControl)
            }
        }
        var i = 0
        let btnWidth = Screen_width/4
        for value in array{
//            if (i == 2) {
//                i += 1
//            }
            let x = btnWidth * CGFloat(i)
            value.frame = CGRect.init(x: x, y: 0, width: btnWidth, height: 40)
            i+=1
        }
//        self.publishButton.center = CGPoint.init(x: Screen_width/2, y: 40/2)
 */
        
    }

}


