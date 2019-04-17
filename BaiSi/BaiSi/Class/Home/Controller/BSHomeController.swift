//
//  BSHomeController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSHomeController: BSBaseController {
    lazy var viwModel: BSHomeViewModel = {
        let VM = BSHomeViewModel()
        return VM
    }()
    lazy var titleView: BSHomeTitleView = { [unowned self] in
        let tv = BSHomeTitleView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: Screen_width, height: 44))
        tv.delegate = self
        return tv
    }()
    
    lazy var contentView: BSHomeContentView = { [unowned self] in
        let cv = BSHomeContentView.init(frame: CGRect.init(x: 0, y: titleView.frame.maxY, width: Screen_width, height: Screen_height - titleView.frame.maxY - TAB_BAR_HEIGHT))
        cv.delegate = self
        return cv
    }()
    lazy var viewModel: BSHomeViewModel = {
        let vm = BSHomeViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubView()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
       self.loadData(index: 0)

    }

}

extension BSHomeController {
    
    func setupSubView(){
        let titleaArray = self.viewModel.titleArray
        
        self.titleView.titles = titleaArray
        self.view.addSubview(self.titleView)
      
        self.view.addSubview(self.contentView)
        var contentArray = Array<UIView>()
        
        for _ in titleaArray{
            let subVc = BSHomeSubController()
            contentArray.append(subVc.view)
            self.addChild(subVc)
        }
        self.contentView.contentArray = contentArray
    }
    
    func loadData(index : Int) {
        let subVc = self.children[index] as! BSHomeSubController
        
        let dict = self.viewModel.typeArray[index]
        guard let type = dict["type"] else {
            return
        }
        subVc.type = type
        subVc.viewModel.loadData(type: type)
    }
}

extension BSHomeController : BSHomeTitleViewDelegate , BSHomeContentViewDelegate{
    func titleDidSelect(label: UILabel, index: Int) {
        self.contentView.scrollToIndexPage(index: index)
        self.loadData(index: index)
    }
    //    MARK: - BSHomeContentViewDelegate
    func contentViewDidScroll(index: Int) {
        self.titleView.selectIndex = index
    }
    
    func contentViewDidEndScroll(index: Int) {
        let dict = self.viewModel.typeArray[index]
        guard let type = dict["type"] else {
            return
        }
        DLog(message: type)
    }

}
