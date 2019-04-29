//
//  BSHomeSubViewModel.swift
//  BaiSi
//
//  Created by wzh on 2019/4/9.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeSubViewModel: NSObject {

    var rloadData : ((Array<BSHomeSubFrameModel>) -> Void)?
    var moreData : ((Array<BSHomeSubFrameModel>) -> Void)?
    var page : Int = 0

    
    func loadData(type: String){
        self.page = 0

        let parameter = ["a":"list","c":"data","type": type]
        
        let url = "http://api.budejie.com/api/api_open.php"
        
        BSNetworkTool.getWithUrl(urlString: url, parameter:parameter, succee: { (result : Dictionary) in
            if self.rloadData != nil {
                var array = Array<BSHomeSubFrameModel>()
                let list  = result["list"] as! Array<Dictionary<String, Any>>
                
                for dict in list {
                    guard let model = BSHomeSubModel.deserialize(from: dict) else{ continue}
                    model.thumbnailImageUri()
                    let frameModel = BSHomeSubFrameModel()
                    frameModel.model = model
                    
                    array.append(frameModel)
                }
                self.rloadData!(array)
            }
//            DLog(message: result)
        }) { (error) in
            DLog(message: error)
        }
        
    }
    
    func loadMoreData(type: String, maxTime: String)  {
        self.page += 1

        let parameter = ["a":"list","c":"data","type": type,"page":"\(self.page)","maxtime":maxTime]
        
        let url = "http://api.budejie.com/api/api_open.php"
        DLog(message: parameter)
        BSNetworkTool.getWithUrl(urlString: url, parameter:parameter, succee: { (result : Dictionary) in
            if self.moreData != nil {
                var array = Array<BSHomeSubFrameModel>()
                let list  = result["list"] as! Array<Dictionary<String, Any>>
                
                for dict in list {
                    guard let model = BSHomeSubModel.deserialize(from: dict) else{ continue}
                    model.thumbnailImageUri()
                    let frameModel = BSHomeSubFrameModel()
                    frameModel.model = model
                    
                    array.append(frameModel)
                }
                self.moreData!(array)
            }else{
            }
            //            DLog(message: result)
        }) { (error) in
            DLog(message: error)
        }
    }
    
    
}
