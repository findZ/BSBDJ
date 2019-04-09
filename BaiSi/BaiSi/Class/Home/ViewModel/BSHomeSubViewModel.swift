//
//  BSHomeSubViewModel.swift
//  BaiSi
//
//  Created by wzh on 2019/4/9.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeSubViewModel: NSObject {

    var rloadData : ((Array<Any>) -> Void)?
    
    func loadData(type: String){
        let parameter = ["a":"list","c":"data","type": type]
        
        let url = "http://api.budejie.com/api/api_open.php"
        
        BSNetworkTool.getWithUrl(urlString: url, parameter:parameter, succee: { (result : Dictionary) in
            if self.rloadData != nil {
                self.rloadData!(result["list"] as! Array<Any>)
            }
//            DLog(message: result)
        }) { (error) in
            DLog(message: error)
        }
        
    }
    
    
}
