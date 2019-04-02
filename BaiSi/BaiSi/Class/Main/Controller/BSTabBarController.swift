//
//  BSTabBarController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setValue(BSMainTabBar(), forKey: "tabBar")
        self.addChildController()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BSTabBarController {
    
    func addChildController()  {
        self.setupSubViewController(childVc: BSHomeController(), title: "首页", imageName: "home_icon", selectedImageName: "home_icon_select")
        self.setupSubViewController(childVc: BSCommunityController(), title: "社区", imageName: "community_icon", selectedImageName: "community_icon_select")
        self.setupSubViewController(childVc: BSAttentionController(), title: "关注", imageName: "attention_icon", selectedImageName: "attention_icon_select")
        self.setupSubViewController(childVc: BSMineController(), title: "我的", imageName: "mine_icon", selectedImageName: "mine_icon_select")
    }
    
    func setupSubViewController(childVc: UIViewController, title: String, imageName: String, selectedImageName: String){
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVc.tabBarItem.selectedImage = UIImage.init(named: selectedImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.addChild(childVc)
    }
}
