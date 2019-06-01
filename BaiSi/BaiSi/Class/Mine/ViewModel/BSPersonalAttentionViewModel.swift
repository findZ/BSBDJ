//
//  BSPersonalAttentionViewModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/6/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSPersonalAttentionViewModel: BSBaseViewModel {

    lazy var dataArray: Array<BSPersonalAttentionModel> = {
        let array = Array<BSPersonalAttentionModel>()
        return array
    }()
    
    var didLoadDataFinish : ((Bool ) -> Void)?
    
    func loadAttenionData(userId : String)  {
        let url = "http://d.api.budejie.com/user/\(userId)/follow_list/\(self.np)/"
        
        self.loadData(url: url, parameter: Dictionary(), succeed: { (result : Dictionary<String, Any>) in
           
            guard let data = result["data"] as? Dictionary<String, Any> else {return}
            
            guard let list : Array<Dictionary<String, Any>> = data["list"] as? Array<Dictionary<String, Any>> else{
                guard (self.error != nil) else {return}
                let error = BSError.init(value: "error  not more data")
                self.error!(error)
                return
            }
            
            for dict in list {
                guard let model = BSPersonalAttentionModel.deserialize(from: dict) else{ continue}
                self.dataArray.append(model)
            }
            if self.didLoadDataFinish != nil {
                self.didLoadDataFinish!(true);
            }
            
            
        }) { (error) in
            DLog(message: error)
            guard (self.error != nil) else {return}
            self.error!(error)
        }
    }
}
