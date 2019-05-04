//
//  BSBaseViewModel.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

protocol BSViewModelDelagate : NSObjectProtocol {
    func loadNewDataDidFinish(dataArray: Array<Any>)
    func loadMoreDataDidFinish(dataArray: Array<Any>)
}

class BSBaseViewModel: NSObject {
    typealias succeed = (_ result:Dictionary<String, Any>)->Void
    typealias failure = (_ error: Error)->Void
    
    ///加载更多需要字段
    var np : NSNumber = NSNumber.init(value: 0)
    var error : ((Error) -> Void)?

    weak var delegate : BSViewModelDelagate?
    
    func loadData(url: String, parameter : Dictionary<String, Any>,succeed : @escaping succeed,failure: @escaping failure) {
    
        BSNetworkTool.getWithUrl(urlString: url, parameter: parameter, success: { (result: Dictionary<String, Any>) in
            succeed(result)
        }) { (error: Error) in
            failure(error)
        }
    }
}
