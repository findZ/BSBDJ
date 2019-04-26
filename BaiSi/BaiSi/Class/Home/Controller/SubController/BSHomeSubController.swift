//
//  BSHomeSubController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import MJRefresh
import ZFPlayer

class BSHomeSubController: BSBaseController {

    var type : String?
    var page : Int = 0
    lazy var player: ZFPlayerController = { [unowned self] in
        let pm = ZFAVPlayerManager()
        let player = ZFPlayerController.player(with: self.tableView, playerManager:pm, containerViewTag: 100)
        player.controlView = self.controlView
        player.shouldAutoPlay = false
        return player
    }()
    lazy var controlView: ZFPlayerControlView = {
        let controlV = ZFPlayerControlView()
        controlV.prepareShowLoading = true
        return controlV
    }()
    
    
    lazy var viewModel: BSHomeSubViewModel = { [unowned self] in
        let VM = BSHomeSubViewModel()
        VM.rloadData = {(dataArray: Array<BSHomeSubFrameModel>) in
            self.tableView.mj_header.endRefreshing()
            self.dataArray = dataArray
            
            if self.type == "41" {
                var urls = Array<URL>()
                for frameModel in dataArray {
                    let model = frameModel.model
                    guard let uri = model?.videouri else{return}
                    let url = URL.init(string:"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/3612804_e50cb68f52adb3c4c3f6135c0edcc7b0_3.mp4")
                    urls.append(url!)
                }
                self.player.assetURLs = urls
            }
            
            self.tableView.reloadData()
        }
        VM.moreData = {(dataArray: Array<BSHomeSubFrameModel>) in
            self.tableView.mj_footer.endRefreshing()
            
            for frameModel in dataArray {
                self.dataArray?.append(frameModel)
            }
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
        tabV.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            guard (self.type != nil) else {
                tabV.mj_header.endRefreshing()
                return
            }
            self.page = 0
            self.viewModel.loadData(type: self.type!)
        })
        tabV.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            guard (self.type != nil) else {
                tabV.mj_footer.endRefreshing()
                return
            }
            let model = self.dataArray?.last?.model
            guard (model?.t != nil) else {
                tabV.mj_footer.endRefreshing()
                return
            }
            self.page += 1
            self.viewModel.loadMoreData(type: self.type!, page: self.page, maxTime: model!.t!)
        })
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
        cell.indexPath = indexPath
        cell.delegate = self
        let frameModel = self.dataArray?[indexPath.row]
        cell.frameModel = frameModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frameModel = self.dataArray?[indexPath.row]
        return frameModel!.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// 如果正在播放的index和当前点击的index不同，则停止当前播放的index
        if self.player.playingIndexPath != indexPath {
            self.player.stopCurrentPlayingCell()
        }
        /// 如果没有播放，则点击进详情页会自动播放
        if (self.player.currentPlayerManager.isPlaying == false){
        }
    }
}

extension BSHomeSubController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidEndDecelerating()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.zf_scrollViewDidEndDraggingWillDecelerate(decelerate)
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScrollToTop()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewDidScroll()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
    }
}

extension BSHomeSubController : BSHomeSubCellDelegate{
    func imageViewDidClick(imageView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray?[indexPath.row]
        guard frameModel?.model!.image0 != nil else {
            return
        }
        let imageUrl = URL.init(string: (frameModel?.model?.image0!)!)
        ZHImageViewer.shared.showImageViewer(imageView: imageView, imageUrl: imageUrl!)
    }
    
    func videoViewDidClick(videoView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray?[indexPath.row]
        let model = frameModel?.model
        
        self.player.playTheIndexPath(indexPath, scrollToTop: false)
        self.controlView.showTitle(model?.text, coverURLString: model!.thumbnailImage, fullScreenMode: ZFFullScreenMode.portrait)
    }
    
    func audioViewDidClick(audioView: UIImageView, indexPath: IndexPath) {
        
    }
    

    
}
