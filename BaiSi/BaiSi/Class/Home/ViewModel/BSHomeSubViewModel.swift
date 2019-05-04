//
//  BSHomeSubViewModel.swift
//  BaiSi
//
//  Created by wzh on 2019/4/9.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeSubViewModel: BSBaseViewModel {
    
    var type : String = "1"
   
    ///获取评论数据所需字段
    var id : String = "0"
}

///最新接口
extension BSHomeSubViewModel {
    func loadNewData()  {
        let url = "http://s.budejie.com/topic/list/zuixin/\(self.type)/bs0315-iphone-4.5.1/0-20.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary) in
            var array = Array<BSHomeDataModelFrame>()
            let list  = result["list"] as! Array<Dictionary<String, Any>>
            let info = result["info"] as! Dictionary<String, Any>
            if info["np"] is NSNumber {
                self.np = info["np"] as! NSNumber
            }
            for dict in list {
                guard let model = BSHomeDataModel.deserialize(from: dict) else{ continue}
                let frameModel = BSHomeDataModelFrame()
                frameModel.model = model
                array.append(frameModel)
            }
            if self.delegate != nil {
                self.delegate?.loadNewDataDidFinish(dataArray: array)
            }
        }) { (error: Error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    
    func loadMoreData()  {
        if self.np == 0 {
            guard (self.error != nil) else {return}
            let error = BSError.init(value: "error  not more data")
            self.error!(error)
            return
        }
        let url = "http://s.budejie.com/topic/list/zuixin/\(self.type)/bs0315-iphone-4.5.1/\(self.np)-20.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary) in
            
            var array = Array<BSHomeDataModelFrame>()
            let info = result["info"] as! Dictionary<String, Any>
            if info["np"] is NSNumber {
                self.np = info["np"] as! NSNumber
            }
            
            guard let list : Array<Dictionary<String, Any>> = result["list"] as? Array<Dictionary<String, Any>> else{
                guard (self.error != nil) else {return}
                let error = BSError.init(value: "error  not more data")
                self.error!(error)
                return
            }
            
            for dict in list {
                guard let model = BSHomeDataModel.deserialize(from: dict) else{ continue}
                let frameModel = BSHomeDataModelFrame()
                frameModel.model = model
                array.append(frameModel)
            }
            if self.delegate != nil {
                self.delegate?.loadMoreDataDidFinish(dataArray: array)
            }
        }) { (error: Error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    
    
    func loadCommentNewData()  {
        let url = "http://c.api.budejie.com/topic/comment_list/\(self.id)/0/bs0315-iphone-4.5.1/0-20.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary) in
            var array = Array<BSHomeCommentFrameModel>()
            let normal = result["normal"] as! Dictionary<String, Any>
            let list  = normal["list"] as! Array<Dictionary<String, Any>>
            let info = normal["info"] as! Dictionary<String, Any>
            if info["np"] is NSNumber {
                self.np = info["np"] as! NSNumber
            }
            
            for dict in list {
                guard let model = BSHomeCommentModel.deserialize(from: dict) else{ continue}
                let frameModel = BSHomeCommentFrameModel()
                frameModel.model = model
                array.append(frameModel)
            }
            if self.delegate != nil {
                self.delegate?.loadNewDataDidFinish(dataArray: array)
            }
        }) { (error: Error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    
    func loadCommentMoreData()  {
        if self.np == 0 {
            guard (self.error != nil) else {return}
            let error = BSError.init(value: "error  not more data")
            self.error!(error)
            return
        }
        let url = "http://c.api.budejie.com/topic/comment_list/\(self.id)/0/bs0315-iphone-4.5.1/\(self.np)-20.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary) in
            var array = Array<BSHomeCommentFrameModel>()
            let normal = result["normal"] as! Dictionary<String, Any>
            let list  = normal["list"] as! Array<Dictionary<String, Any>>
            let info = normal["info"] as! Dictionary<String, Any>
            if info["np"] is NSNumber {
                self.np = info["np"] as! NSNumber
            }
            for dict in list {
                guard let model = BSHomeCommentModel.deserialize(from: dict) else{ continue}
                let frameModel = BSHomeCommentFrameModel()
                frameModel.model = model
                array.append(frameModel)
            }
            if self.delegate != nil {
                self.delegate?.loadMoreDataDidFinish(dataArray: array)
            }
        }) { (error: Error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    
}
