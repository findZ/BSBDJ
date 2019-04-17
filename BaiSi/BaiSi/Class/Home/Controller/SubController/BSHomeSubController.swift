//
//  BSHomeSubController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import Kingfisher

class BSHomeSubController: BSBaseController {

    lazy var viewModel: BSHomeSubViewModel = { [unowned self] in
        let VM = BSHomeSubViewModel()
        VM.rloadData = {(dataArray: Array<Any>) in
            self.dataArray = dataArray as? Array<BSHomeSubFrameModel>
            self.tableView.reloadData()
        }
        return VM
    }()
    
    private var dataArray : Array<BSHomeSubFrameModel>?
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_height - TAB_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT))
        tabV.dataSource = self
        tabV.delegate = self
        tabV.separatorStyle = UITableViewCell.SeparatorStyle.none
        tabV.backgroundColor = UIColor.groupTableViewBackground
        tabV.tableFooterView = UIView.init()
        return tabV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        // Do any additional setup after loading the view.
        self.setupSubView()
       
        
    }
    
   private func setupSubView() {
        self.view.addSubview(self.tableView)
    }

}

extension BSHomeSubController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BSHomeSubCell.cellWithTableView(tableView: tableView)
        cell.index = indexPath.row
        cell.delegate = self
        let frameModel = self.dataArray?[indexPath.row]
        cell.frameModel = frameModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frameModel = self.dataArray?[indexPath.row]
        return frameModel!.cellHeight
    }
}
extension BSHomeSubController : BSHomeSubCellDelegate{
    
    func imageViewDidClick(imageView: UIImageView, index: Int) {        
        ZHImageViewer.shared.showImageViewer(imageView: imageView, dataArray: self.dataArray!, currentIndexPath: index)

    }
}
