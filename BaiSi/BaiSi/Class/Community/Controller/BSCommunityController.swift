//
//  BSCommunityController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSCommunityController: BSBaseController {
    lazy var viewModel: BSCommunityViewModel = {
        let vm = BSCommunityViewModel()
        vm.delegate = self
        vm.error = { (error : Error) in
            DLog(message: error)
        }
        return vm
    }()
    private lazy var tableView: UITableView = { [unowned self] in
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_height - TAB_BAR_HEIGHT))
        tabV.dataSource = self
        tabV.delegate = self
        tabV.separatorStyle = UITableViewCell.SeparatorStyle.none
        tabV.backgroundColor = UIColor.groupTableViewBackground
        tabV.tableFooterView = UIView.init()
        
        return tabV
    }()
    lazy var dataArray: Array<BSThemeModel> = {
        let array = Array<BSThemeModel>()
        return array
    }()
    var selectIndexPath : IndexPath = IndexPath.init(row: 0, section: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.viewModel.loadCommuniityData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.deselectRow(at: selectIndexPath, animated: true)
    }

}
extension BSCommunityController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BSThemeCell.cellWithTableView(tableView: tableView)
        let model = self.dataArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndexPath = indexPath
        let model = self.dataArray[indexPath.row]
        let detailVc = BSCommunityDetailController()
        detailVc.model = model
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
extension BSCommunityController : BSViewModelDelagate {
    func loadNewDataDidFinish(dataArray: Array<Any>) {
        self.dataArray = dataArray as! Array<BSThemeModel>
        self.tableView.reloadData()
    }
    func loadMoreDataDidFinish(dataArray: Array<Any>) {
        
    }
}
