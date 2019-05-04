//
//  BSMineViewModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/4.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSMineViewModel: BSBaseViewModel {
    
    var userId : String?
    var didFinish : ((Any) -> Void)?

    /// 加载用户信息
    func loadUserProfileData()  {
        let url = "http://d.api.budejie.com/user/profile?userid=\(self.userId!)"        
        self.loadData(url: url, parameter: Dictionary(), succeed: { (result : Dictionary<String, Any>) in
            
            if self.didFinish != nil {
                let data = result["data"] as! Dictionary<String, Any>
                guard let model = BSUserProfileModel.deserialize(from: data) else{ return}
                self.didFinish!(model)
            }
        }) { (error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
    func loadTieZiData()  {
        let url = "http://s.budejie.com/topic/user-topic/\(self.userId!)/1/desc/bsbdjhd-iphone-5.0.8/\(self.np)-20.json?appname=bsbdjhd&asid=1940339E-9537-4DF5-8BBC-4CD7BF2F9EB1&client=iphone&device=iPhone8%2C2&from=ios&jbk=0&market=appstore&openudid=9a3246cd991fce4a8f047a6af57728f8265f263f&t=1556952664&uid=23069386&ver=5.0.8"
        self.loadData(url: url, parameter: Dictionary(), succeed: { (result : Dictionary<String, Any>) in
            
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
        }) { (error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
        
    }
}
