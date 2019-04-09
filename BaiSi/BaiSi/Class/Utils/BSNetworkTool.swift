//
//  BSNetworkTool.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import Alamofire



typealias succeeClosure = (_ result:Dictionary<String, Any>)->Void
typealias failureClosure = (_ error: Error)->Void

class BSNetworkTool: NSObject {

    static func getWithUrl(urlString: String, parameter : Dictionary<String, String>, succee: @escaping succeeClosure, failure: @escaping failureClosure ){
        Alamofire.request(urlString,method:.get,parameters: parameter).responseJSON { (response) in
            if let data = response.data {
                
                let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                guard dict != nil else {
                    return
                }
                succee(dict! as! Dictionary<String, Any>)
            }else{
                failure(response.error!)
            }
        }
    }
}
