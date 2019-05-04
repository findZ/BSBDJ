//
//  BSBaseController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSBaseController: UIViewController {

    lazy var navigationBar: BSNavigationBar = {
        let nav = BSNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: NAVIGATION_BAR_HEIGHT))
        nav.backgroundColor = UIColor.white
        nav.leftButton.addTarget(self, action: #selector(leftButtonClick), for: UIControl.Event.touchUpInside)
        
        nav.isHidden = true
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.setupNavigationBar()
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return UIStatusBarStyle.default
        }
    }
    override var prefersStatusBarHidden: Bool {
        get {
            return false
        }
    }
}

extension BSBaseController {
 
    func setupNavigationBar(){
        self.view.addSubview(self.navigationBar)
    }
    @objc func leftButtonClick(){
        if self.navigationController?.viewControllers.count ?? 0 > 1{
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
