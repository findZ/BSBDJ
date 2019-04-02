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

        return btn
    }()
    var tabBarButtonArray : Array<Any> = Array()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.publishButton)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTabBarItems()

    }
    
    
    func setupTabBarItems() {
        let width = self.width()
        let height = self.height()
        self.publishButton.center = CGPoint.init(x: width/2, y: height/2)
        
        let tabBarButtonW : CGFloat = width/5
        let tabBarButtonH : CGFloat = height
        let tabBarButtonY : CGFloat = 0.0
        
        var index : CGFloat = 0
        
        for subView in self.subviews {
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                var tabBarButtonX = index * tabBarButtonW
                if index >= 2{
                    tabBarButtonX += tabBarButtonW
                }
                self.tabBarButtonArray.append(subView)
                subView.frame = CGRect.init(x: tabBarButtonX, y: tabBarButtonY, width: tabBarButtonW, height: tabBarButtonH)
                index+=1
            }
        }
    }
}

