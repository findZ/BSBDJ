//
//  BSHomeDetailsController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/30.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import MJRefresh


class BSHomeDetailsController: BSBaseController {

    var model : BSHomeSubModel? {
        didSet{
            let iconUrl = URL.init(string: model!.profile_image!)
            self.navigationBar.imageView.sd_setImage(with: iconUrl, completed: nil)
            self.navigationBar.title = model?.name
        }
    }
    private lazy var tableView: UITableView = { [unowned self] in
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: NAVIGATION_BAR_HEIGHT, width: Screen_width, height: Screen_height - NAVIGATION_BAR_HEIGHT))
        tabV.dataSource = self
        tabV.delegate = self
        tabV.separatorStyle = UITableViewCell.SeparatorStyle.singleLineEtched
        tabV.backgroundColor = UIColor.groupTableViewBackground
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height: 200))
        headerView.backgroundColor = UIColor.randomColor()
        tabV.tableHeaderView = headerView
        tabV.tableFooterView = UIView.init()
        tabV.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
//            guard (self.type != nil) else {
//                tabV.mj_header.endRefreshing()
//                return
//            }
//            self.viewModel.loadData(type: self.type!)
        })
        tabV.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
//            guard (self.type != nil) else {
//                tabV.mj_footer.endRefreshing()
//                return
//            }
//            let model = self.dataArray?.last?.model
//            guard (model?.t != nil) else {
//                tabV.mj_footer.endRefreshing()
//                return
//            }
//            self.viewModel.loadMoreData(type: self.type!, maxTime: model!.t!)
        })
        return tabV
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.randomColor()
        self.navigationBar.isHidden = false
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
        // http://api.budejie.com/api/api_open.php?a=dataList&c=comment&data_id=22062938&hot=1

    }

}

extension BSHomeDetailsController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "BSHomeSubCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell != nil {
            return cell as! BSHomeSubCell
        }else {
            cell = BSHomeSubCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: identifier)
        }
        return cell as! BSHomeSubCell
    }
    
    
}
