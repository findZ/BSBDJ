//
//  BSPublishController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSPublishController: BSBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = UIButton(type: UIButton.ButtonType.infoLight)
        btn.frame = CGRect.init(x: 10, y: STATUS_BAR_HEIGHT, width: 40, height: 40)
        btn.backgroundColor = UIColor.randomColor()
        btn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnClick(){
        self.dismiss(animated: true, completion: nil)
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
