//
//  BSCommunityViewModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSCommunityViewModel: BSBaseViewModel {
    
    lazy var typeArray: Array<Dictionary<String, String>> = {
        let array = [["title":"最新","type":"new"],["title":"精华","type":"jingxuan"],["title":"最热","type":"hot"]]
        return array
    }()
    
    lazy var titleArray: Array<String> = { [unowned self] in
        var arr = Array<String>()
        for dict : Dictionary<String, String> in self.typeArray{
            guard let title = dict["title"] else{ continue }
            arr.append(title)
        }
        return arr
        }()

    var theme_id : String = "0"
    var type : String = "new"
    
    func loadCommuniityData() {
         let url = "http://d.api.budejie.com/forum/subscribe/bsbdjhd-iphone-5.0.8.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary<String, Any>) in
            let list = result["list"] as! Array<Dictionary<String, Any>>
            var array = Array<BSThemeModel>()
            for dict in list {
                guard let model = BSThemeModel.deserialize(from: dict) else{ continue}
                array.append(model)
            }
            if self.delegate != nil {
                self.delegate?.loadNewDataDidFinish(dataArray: array)
            }
            
        }) { (error) in
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    func loadCommuniityNewSubData() {
        let url = "http://d.api.budejie.com/topic/forum/\(self.theme_id)/1/\(self.type)/bsbdjhd-iphone-5.0.8/0-20.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary<String, Any>) in
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
            
        }) { (error) in
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    
    func loadCommuniityMoreSubData() {
        let url = "http://d.api.budejie.com/topic/forum/\(self.theme_id)/1/\(self.type)/bsbdjhd-iphone-5.0.8/\(self.np)-20.json"
        BSNetworkTool.getWithUrl(urlString: url, parameter: Dictionary(), success: { (result : Dictionary<String, Any>) in
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
                self.delegate?.loadMoreDataDidFinish(dataArray: array)
            }
            
        }) { (error) in
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
}
