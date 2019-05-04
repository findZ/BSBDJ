//
//  BSNetworkTool.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import Alamofire



typealias successClosure = (_ result:Dictionary<String, Any>)->Void
typealias failureClosure = (_ error: Error)->Void

struct BSError : Error {
    var value : String?
    init(value: String) {
        self.value = value
    }
}

class BSNetworkTool: NSObject {

    static func getWithUrl(urlString: String, parameter : Dictionary<String, Any>, success: @escaping successClosure, failure: @escaping failureClosure ){
        Alamofire.request(urlString,method:.get,parameters: parameter).responseJSON { (response) in
            if let data = response.data {
                
                var dict : Any
                do {
                    dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    guard dict is Dictionary<String, Any> else {
                        let error = BSError.init(value: "error data not dictionary")
                        failure(error)
                        return
                    }
                    success(dict as! Dictionary<String, Any>)
                } catch  {
                    let error = BSError.init(value: "error data not dictionary")
                    DLog(message: error)
                }

                
            }else{
                failure(response.error!)
            }
        }
    }
}
