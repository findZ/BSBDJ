//
//  BSBaseController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupTabBarItem()
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

extension BSBaseController {
    func setupTabBarItem()  {
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray], for: UIControl.State.normal)
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.withRGB(255, 47, 86)], for: UIControl.State.selected)
    }
}
