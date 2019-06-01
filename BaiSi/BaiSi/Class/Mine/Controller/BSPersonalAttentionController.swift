//
//  BSPersonalAttentionController.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/6/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage


class BSPersonalAttentionController: BSBaseController {

    var userId : String?
    
    lazy var viewModel: BSPersonalAttentionViewModel = { [unowned self] in
        let vm = BSPersonalAttentionViewModel()
        vm.didLoadDataFinish = { (isOk : Bool) in
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.tableView, animated: true)

        }
        vm.error = {(error: Error) in
            MBProgressHUD.hide(for: self.tableView, animated: true)

        }
        return vm
    }()
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: NAVIGATION_BAR_HEIGHT, width: Screen_width, height: Screen_height - NAVIGATION_BAR_HEIGHT))
        tabV.dataSource = self
        tabV.delegate = self
        tabV.separatorStyle = UITableViewCell.SeparatorStyle.none
        tabV.backgroundColor = UIColor.white
        tabV.rowHeight = 65
        tabV.tableFooterView = UIView.init()
        
        return tabV
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.title = "关注"
        
        guard (self.userId != nil) else {
            return
        }
        self.viewModel.loadAttenionData(userId: self.userId!)
        MBProgressHUD.showAdded(to: self.tableView, animated: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




extension BSPersonalAttentionController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BSPersonalAttentionCell.cellWithTableView(tableView:tableView)
        let model = self.viewModel.dataArray[indexPath.row]
        cell.model = model
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.dataArray[indexPath.row]

        let mineVc = BSMineController.init()
        mineVc.userId = model.id
        self.navigationController?.pushViewController(mineVc, animated: true)
        
    }
   
}
