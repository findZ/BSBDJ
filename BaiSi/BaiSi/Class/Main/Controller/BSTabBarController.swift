//
//  BSTabBarController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSTabBarController: UITabBarController {

    var bsTabBar : BSMainTabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = BSMainTabBar()
        tabBar.customDelegate = self
        self.bsTabBar = tabBar
        self.setValue(tabBar, forKey: "tabBar")
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
        childVc.tabBarItem.title = title
    childVc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.withRGB(255, 47, 86)], for: UIControl.State.selected)//必须在这里设置，如果在childVc中设置tabBarItem属性会造成tabBarItem顺序错乱
        childVc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVc.tabBarItem.selectedImage = UIImage.init(named: selectedImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let nav = BSNavigationController.init(rootViewController: childVc)
        nav.setNavigationBarHidden(true, animated: false)
        self.addChild(nav)
    }
}

extension BSTabBarController : BSMainTabBarDelegate {
    func publishButtonClick(button: UIButton) {
        self.present(BSPublishController(), animated: true, completion: nil)
    }
    
    override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        let subView : UIView = self.bsTabBar?.tabBarButtonArray[index] as! UIView
       
        UIView.animate(withDuration: 0.25){
            subView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)//缩放
            //            subView.transform = CGAffineTransform.init(rotationAngle:CGFloat(Double.pi))//旋转

        }
        UIView.animate(withDuration: 0.5){
            subView.transform = CGAffineTransform.identity
        }

    }
    
}
