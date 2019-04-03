//
//  BSHomeViewModel.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeViewModel: NSObject {

    func loadNewData(){
        let parameter = ["a":"list","c":"data","type": "1"]
        
        let url = "http://api.budejie.com/api/api_open.php"
        
        BSNetworkTool.getWithUrl(urlString: url, parameter:parameter, succee: { (result) in
            DLog(message: result)
        }) { (error) in
            DLog(message: error)
        }
    }
}
