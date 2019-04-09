//
//  BSHomeViewModel.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeViewModel: NSObject {

    lazy var typeArray: Array<Dictionary<String, String>> = {
        let array = [["title":"推荐","type":"1"],["title":"视频","type":"41"],["title":"图片","type":"10"],["title":"笑话","type":"29"],["title":"声音","type":"31"]]
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
    
}
