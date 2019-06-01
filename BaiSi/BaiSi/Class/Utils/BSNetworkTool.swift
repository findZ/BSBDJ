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

let _headers = ["uid":"23069386","appname":"bsbdjhd","openudid":"9a3246cd991fce4a8f047a6af57728f8265f263f", "asid": "1940339E-9537-4DF5-8BBC-4CD7BF2F9EB1"]

class BSNetworkTool: NSObject {

    static func getWithUrl(urlString: String, parameter : Dictionary<String, Any>, success: @escaping successClosure, failure: @escaping failureClosure ){
        Alamofire.request(urlString,method:.get,parameters: parameter,headers:_headers).responseJSON { (response) in
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
