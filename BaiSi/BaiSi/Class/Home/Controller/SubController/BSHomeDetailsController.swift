//
//  BSHomeDetailsController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/30.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import MJRefresh
import ZFPlayer
import AVFoundation

class BSHomeDetailsController: BSBaseController {

    var model : BSHomeDataModel? {
        didSet{
            self.setupHeaderData(model: model!)
        }
    }
    lazy var dataArray: Array<BSHomeCommentFrameModel> = {
        let array = Array<BSHomeCommentFrameModel>()
        return array
    }()
    lazy var headerView: BSHomeDetailView = {  [unowned self] in
        let hdv = BSHomeDetailView.init()
        hdv.contentViewDidClick = { (model: BSHomeDataModel, contentView: UIImageView) in
            self.headerViewContentViewDidClick(model: model, contentView: contentView)
        }
        return hdv
    }()
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: NAVIGATION_BAR_HEIGHT, width: Screen_width, height: Screen_height - NAVIGATION_BAR_HEIGHT))
        tabV.dataSource = self
        tabV.delegate = self
        tabV.separatorStyle = UITableViewCell.SeparatorStyle.none
        tabV.backgroundColor = UIColor.groupTableViewBackground
        tabV.tableFooterView = UIView.init()
        tabV.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.viewModel.loadCommentNewData()
        })
        tabV.mj_footer = MJRefreshBackStateFooter.init(refreshingBlock: {
            guard let model = self.dataArray.last?.model else {
                self.tableView.mj_footer.endRefreshing()
                return
            }
            self.viewModel.loadCommentMoreData()
        })
        return tabV
        }()
    
    lazy var viewModel: BSHomeSubViewModel = { [unowned self] in
        let vm = BSHomeSubViewModel()
        vm.delegate = self
        vm.error = { (error : Error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            DLog(message: error)
        }
        return vm
    }()
    lazy var audioPlayer: AVPlayer = {
        let apl = AVPlayer.init()
        return apl
    }()
    lazy var player: ZFPlayerController = { [unowned self] in
        let pm = ZFAVPlayerManager()
        let player = ZFPlayerController.init(playerManager: pm, containerView: self.headerView.contentView)
        if self.model?.type == "video" {
            let uri = model?.video?.video?.last
            let url = URL.init(string:uri ?? "123.mp4")
            player.assetURLs = [url] as? [URL]
        }
        player.controlView = self.controlView
        player.shouldAutoPlay = false
        return player
        }()
    lazy var controlView: ZFPlayerControlView = {
        let controlV = ZFPlayerControlView()
        controlV.prepareShowLoading = true
        return controlV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = false
        self.view.addSubview(self.tableView)
        self.viewModel.loadCommentNewData()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.audioPlayer.pause()
        self.player.stop()
    }

    deinit {
        DLog(message: self)
    }
}

extension BSHomeDetailsController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BSHomeCommentsCell.cellWithTableView(tableView: tableView)
        cell.indexPath = indexPath
        let frameModel = self.dataArray[indexPath.row]
        cell.delegate = self
        cell.frameModel = frameModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frameModel = self.dataArray[indexPath.row]

        return frameModel.cellHeight
    }
    
}

extension BSHomeDetailsController {
    
    func setupHeaderData(model : BSHomeDataModel)  {
        let iconUrl = URL.init(string: model.u!.header!.last!)
        self.navigationBar.imageView.sd_setImage(with: iconUrl, placeholderImage: UIImage.init(named: "avatar_m_70_70x70_"))
        self.navigationBar.title = model.u?.name
        if model.u!.is_v! {
            self.navigationBar.vipView.isHidden = false
        }else{
            self.navigationBar.vipView.isHidden = true
        }
        let frameModel = BSHomeDetailHeaderFrameModel.init()
        frameModel.model = model
        self.viewModel.id = model.id!
        self.headerView.frameModel = frameModel
        self.headerView.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: frameModel.height!)
        self.tableView.tableHeaderView = self.headerView
    }
    func headerViewContentViewDidClick(model: BSHomeDataModel, contentView: UIImageView) {
        DLog(message: headerView)
        if model.type == "audio" {//音频
            let url = URL.init(string: model.audio!.audio!.last!)
            guard url != nil else {
                return
            }
            if model.isPlayAudio == true {
                model.isPlayAudio = false
                self.audioPlayer.pause()
                contentView.stopAnimating()
            }else{
                
                model.isPlayAudio = true
                let playItem = AVPlayerItem.init(url: url!)
                self.audioPlayer.replaceCurrentItem(with: playItem)
                self.audioPlayer.play()
                contentView.startAnimating()
            }
        }else if model.type == "video"{//视频
            self.player.playTheIndex(0)
            self.controlView.showTitle(model.text, coverURLString: model.video?.thumbnail?.last, fullScreenMode: ZFFullScreenMode.portrait)
        }
    }
}

extension BSHomeDetailsController : BSViewModelDelagate, BSHomeCommentsCellDelegate {
    func iconViewDidClick(iconView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray[indexPath.row]
        let mineVc = BSMineController()
        mineVc.userId = frameModel.model?.user?.id
        self.navigationController?.pushViewController(mineVc, animated: true)
    }
    
    func loadNewDataDidFinish(dataArray: Array<Any>) {
        self.tableView.mj_header.endRefreshing()
        self.dataArray = dataArray as! Array<BSHomeCommentFrameModel>
        self.tableView.reloadData()
    }
    
    func loadMoreDataDidFinish(dataArray: Array<Any>) {
        for frameModel in dataArray {
            self.dataArray.append(frameModel as! BSHomeCommentFrameModel)
        }
        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
    }
    
}
