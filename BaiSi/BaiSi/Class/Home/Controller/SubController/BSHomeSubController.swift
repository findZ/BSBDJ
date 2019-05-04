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
import AVFoundation

class BSHomeSubController: BSBaseController {

    var type : String?
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
        VM.delegate = self
        VM.error = { (error : Error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }

        return VM
    }()
    
    var dataArray : Array<BSHomeDataModelFrame>?
    private lazy var urls : Array<URL> = {
        let array = Array<URL>()
        return array
    }()
    
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
            self.viewModel.loadNewData()
        })
        tabV.mj_footer = MJRefreshBackStateFooter.init(refreshingBlock: {
            self.viewModel.loadMoreData()
        })
        return tabV
    }()
    
    lazy var audioPlayer: AVPlayer = {
        let apl = AVPlayer.init()
        return apl
    }()
    var currentIndexPath : IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = false

        self.view.backgroundColor = UIColor.groupTableViewBackground
        // Do any additional setup after loading the view.
        self.setupSubView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player.stop()
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
        /// 停止播放
        if (self.player.currentPlayerManager.isPlaying == true){
            self.player.stopCurrentPlayingCell()
        }
        let frameModel = self.dataArray?[indexPath.row]
        let detailsVc = BSHomeDetailsController.init()
        detailsVc.model = frameModel?.model
        self.navigationController?.pushViewController(detailsVc, animated: true)
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
    func iconViewDidClick(iconView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray?[indexPath.row]
        let mineVc = BSMineController()
        mineVc.userId = frameModel?.model?.u?.uid
        self.navigationController?.pushViewController(mineVc, animated: true)
        
    }
    
    func imageViewDidClick(imageView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray?[indexPath.row]
   
        var url : String?
        if frameModel?.model?.type == "image" {
            url = frameModel?.model!.image!.big!.last
        }else if frameModel?.model?.type == "gif"{
            url = frameModel?.model!.gif!.images!.last
        }
        if url?.isEmpty == false {
            let imageUrl = URL.init(string:url!)
            ZHImageViewer.shared.showImageViewer(imageView: imageView, imageUrl: imageUrl!)
        }
    }
    
    func videoViewDidClick(videoView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray?[indexPath.row]
        let model = frameModel?.model
        guard let uri = model?.video?.video?.last else{return}
        let url = URL.init(string:uri)!
        
        self.player.playTheIndexPath(indexPath,assetURL: url ,scrollToTop: false)
        self.controlView.showTitle(model?.text, coverURLString: model!.thumbnailImage, fullScreenMode: ZFFullScreenMode.portrait)
    }
    
    func audioViewDidClick(audioView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray?[indexPath.row]
        let model = frameModel?.model
        guard let audio = model?.audio?.audio?.last else {
            return
        }
        let url = URL.init(string:audio)
        
        if model!.isPlayAudio == true {
            model!.isPlayAudio = false
            self.audioPlayer.pause()
            audioView.stopAnimating()
            self.currentIndexPath = nil
        }else{
            if (self.currentIndexPath != nil) {
                let frameModel = self.dataArray?[self.currentIndexPath!.row]
                let model = frameModel?.model
                model!.isPlayAudio = false
                self.tableView.reloadRows(at: [self.currentIndexPath!], with: UITableView.RowAnimation.automatic)
            }
            self.currentIndexPath = indexPath
            model!.isPlayAudio = true
            let playItem = AVPlayerItem.init(url: url!)
            self.audioPlayer.replaceCurrentItem(with: playItem)
            self.audioPlayer.play()
            audioView.startAnimating()
            
        }
    }
    
}
extension BSHomeSubController {
    
    func loadVideoUrl()  {
        self.player.stop()
        for frameModel in self.dataArray! {
            let model = frameModel.model
            if model!.type == "video" {
                guard let uri = model?.video?.video?.last else{return}
                let url = URL.init(string:uri)
                self.urls.append(url!)
            }
        }
        self.player.assetURLs = self.urls
    }
}

extension BSHomeSubController : BSViewModelDelagate {
    func loadNewDataDidFinish(dataArray: Array<Any>) {
        self.tableView.mj_header.endRefreshing()
        self.dataArray = (dataArray as! Array<BSHomeDataModelFrame>)
        self.tableView.reloadData()
        self.loadVideoUrl()
    }
    
    func loadMoreDataDidFinish(dataArray: Array<Any>) {
        for frameModel in dataArray {
            self.dataArray?.append(frameModel as! BSHomeDataModelFrame)
        }
        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
        self.loadVideoUrl()
    }
    
}
