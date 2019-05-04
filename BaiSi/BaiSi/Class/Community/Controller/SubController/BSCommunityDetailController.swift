//
//  BSCommunityDetailController.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSCommunityDetailController: BSBaseController {
    
    var model : BSThemeModel?{
        didSet {
            self.navigationBar.title = self.model?.theme_name
            let iconUrl = URL.init(string: self.model!.image_detail!)
            self.navigationBar.imageView.sd_setImage(with: iconUrl, completed: nil)
        }
    }
    
    lazy var titleView: BSHomeTitleView = { [unowned self] in
        let tv = BSHomeTitleView.init(frame: CGRect.init(x: 0, y: NAVIGATION_BAR_HEIGHT, width: Screen_width, height: 44))
        tv.backgroundColor = UIColor.white
        tv.delegate = self
        return tv
    }()
    
    lazy var contentView: BSHomeContentView = { [unowned self] in
        let cv = BSHomeContentView.init(frame: CGRect.init(x: 15, y: titleView.frame.maxY, width: Screen_width, height: Screen_height - titleView.frame.maxY))
        cv.scrollView.frame = CGRect.init(x: -15, y: 0, width: cv.bounds.size.width, height: cv.bounds.size.height)
        cv.delegate = self
        return cv
    }()
    lazy var viewModel: BSCommunityViewModel = {
        let vm = BSCommunityViewModel()
        return vm
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubView()
        self.loadData(index: 0)
        // Do any additional setup after loading the view.
    }
    
    func setupSubView()  {
        self.navigationBar.isHidden = false
        let titleArray = self.viewModel.titleArray
        self.titleView.titles = titleArray
        
        self.view.addSubview(self.titleView)
        self.view.addSubview(self.contentView)
        var contentArray = Array<UIView>()
        
        for _ in titleArray{
            let subVc = BSCommunityDetailSubController()
            contentArray.append(subVc.view)
            self.addChild(subVc)
            subVc.view.backgroundColor = UIColor.randomColor()
        }
        self.contentView.contentArray = contentArray
    }

}

extension  BSCommunityDetailController : BSHomeTitleViewDelegate,BSHomeContentViewDelegate{
    func titleDidSelect(label: UILabel, index: Int) {
        self.contentView.scrollToIndexPage(index: index)
        self.loadData(index: index)
    }
    
    func contentViewDidScroll(index: Int) {
        self.titleView.selectIndex = index

    }
    
    func contentViewDidEndScroll(index: Int) {
        self.loadData(index: index)
    }
    
    func loadData(index : Int) {
        let subVc = self.children[index] as! BSCommunityDetailSubController
        
        let dict = self.viewModel.typeArray[index]
        guard let type = dict["type"] else {
            return
        }
        subVc.type = type
        subVc.viewModel.type = type
        subVc.viewModel.theme_id = self.model!.theme_id!
        guard (subVc.dataArray?.count) == nil else {
            return
        }
        subVc.viewModel.loadCommuniityNewSubData()
        
    }
}
