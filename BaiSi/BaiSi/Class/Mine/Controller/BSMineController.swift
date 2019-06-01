//
//  BSMineController.swift
//  BaiSi
//
//  Created by wzh on 2019/4/2.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import MJRefresh
import ZFPlayer
import AVFoundation
import MBProgressHUD

class BSMineController: BSBaseController {

    var statusBarStyle : UIStatusBarStyle?
    var userId : String? {
        didSet {
            self.viewModel.userId = userId
        }
    }
    var userModel : BSUserProfileModel? {
        didSet {
            self.headerView.model = userModel!
            let iconUrl = URL.init(string: userModel!.profile_image!)
            self.navigationBar.imageView.sd_setImage(with: iconUrl, completed: nil)
            self.navigationBar.title = userModel!.username
            if userModel!.jie_v == "1" {
                self.navigationBar.vipView.isHidden = false
            }else{
                self.navigationBar.vipView.isHidden = true
            }
        }
    }
    lazy var viewModel: BSMineViewModel = { [unowned self] in
        let vm = BSMineViewModel()
        vm.delegate = self
        vm.didFinish = { (model : Any)  in
            self.userModel = model as? BSUserProfileModel
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        vm.error = {(error: Error) in
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        return vm
    }()
    lazy var headerView: BSMineHeaderView = { [unowned self] in
        let hv = BSMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_width, height:300))
        hv.bottomBarButtonDidlClick = { (button : UIButton) in
            
            switch button.tag {
            case 1 :
                
                break
            case 2 :
                
                break
            case 3 ://关注
                let personalAttentionVc = BSPersonalAttentionController()
                personalAttentionVc.userId = self.userId
                self.navigationController?.pushViewController(personalAttentionVc, animated: true)
                
                break
            case 4 :
                
                break
            default:
                break
            }
            
            
        }
        return hv
    }()
    private lazy var tableView: UITableView = { [unowned self] in
        let tabV = UITableView.init(frame: CGRect.init(x: 0, y: -STATUS_BAR_HEIGHT, width: Screen_width, height: Screen_height + STATUS_BAR_HEIGHT))
        tabV.dataSource = self
        tabV.delegate = self
        tabV.separatorStyle = UITableViewCell.SeparatorStyle.none
        tabV.backgroundColor = UIColor.groupTableViewBackground
        tabV.tableHeaderView = self.headerView
        tabV.tableFooterView = UIView.init()
        tabV.mj_footer = MJRefreshBackStateFooter.init(refreshingBlock: {
            self.viewModel.loadTieZiData()
        })
        
        return tabV
    }()
    lazy var dataArray: Array<BSHomeDataModelFrame> = {
        let array = Array<BSHomeDataModelFrame>()
        return array
    }()
    private lazy var urls : Array<URL> = {
        let array = Array<URL>()
        return array
    }()
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
    lazy var audioPlayer: AVPlayer = {
        let apl = AVPlayer.init()
        return apl
    }()
    var currentIndexPath : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        if userId == "23069386" {
            self.navigationBar.isHidden = true
        }else{
            self.navigationBar.isHidden = false
        }
        self.navigationBar.backgroundColor = UIColor.withRGBA(255, 255, 255, 0)
        self.view.insertSubview(self.tableView, belowSubview: self.navigationBar)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.viewModel.loadUserProfileData()
        self.viewModel.loadTieZiData()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return self.statusBarStyle ?? UIStatusBarStyle.lightContent
        }
    }
}

extension BSMineController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BSHomeSubCell.cellWithTableView(tableView: tableView)
        cell.indexPath = indexPath
        cell.delegate = self
        let frameModel = self.dataArray[indexPath.row]
        cell.frameModel = frameModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frameModel = self.dataArray[indexPath.row]
        return frameModel.cellHeight
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
        let frameModel = self.dataArray[indexPath.row]
        let detailsVc = BSHomeDetailsController.init()
        detailsVc.model = frameModel.model
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }
}

extension BSMineController : UIScrollViewDelegate {
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
        if scrollView.contentOffset.y > (NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT) {
            self.navigationBar.backgroundColor = UIColor.withRGBA(255, 255, 255, 1.0)
            self.statusBarStyle = UIStatusBarStyle.default
            self.navigationBar.isHiddenHeaderView = false
        }else{
            self.navigationBar.backgroundColor = UIColor.withRGBA(255, 255, 255, 0.0)
            self.statusBarStyle = UIStatusBarStyle.lightContent
            self.navigationBar.isHiddenHeaderView = true


        }
        self.setNeedsStatusBarAppearanceUpdate()

//        DLog(message: scrollView.contentOffset.y)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.zf_scrollViewWillBeginDragging()
    }
}

extension BSMineController : BSHomeSubCellDelegate{
    func iconViewDidClick(iconView: UIImageView, indexPath: IndexPath) {
        
        
    }
    
    func imageViewDidClick(imageView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray[indexPath.row]
        
        var url : String?
        if frameModel.model?.type == "image" {
            url = frameModel.model!.image!.big!.last
        }else if frameModel.model?.type == "gif"{
            url = frameModel.model!.gif!.images!.last
        }
        if url?.isEmpty == false {
            let imageUrl = URL.init(string:url!)
            ZHImageViewer.shared.showImageViewer(imageView: imageView, imageUrl: imageUrl!)
        }
    }
    
    func videoViewDidClick(videoView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray[indexPath.row]
        let model = frameModel.model
        guard let uri = model?.video?.video?.last else{return}
        let url = URL.init(string:uri)!
        
        self.player.playTheIndexPath(indexPath,assetURL: url ,scrollToTop: false)
        self.controlView.showTitle(model?.text, coverURLString: model!.thumbnailImage, fullScreenMode: ZFFullScreenMode.portrait)
    }
    
    func audioViewDidClick(audioView: UIImageView, indexPath: IndexPath) {
        let frameModel = self.dataArray[indexPath.row]
        let model = frameModel.model
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
                let frameModel = self.dataArray[self.currentIndexPath!.row]
                let model = frameModel.model
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
extension BSMineController {
    
    func loadVideoUrl()  {
        self.player.stop()
        for frameModel in self.dataArray {
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

extension BSMineController : BSViewModelDelagate {
    func loadNewDataDidFinish(dataArray: Array<Any>) {
        self.tableView.mj_header.endRefreshing()
        self.dataArray = (dataArray as! Array<BSHomeDataModelFrame>)
        self.tableView.reloadData()
        self.loadVideoUrl()
        MBProgressHUD.hide(for: self.view, animated: true)

    }
    
    func loadMoreDataDidFinish(dataArray: Array<Any>) {
        MBProgressHUD.hide(for: self.view, animated: true)

        for frameModel in dataArray {
            self.dataArray.append(frameModel as! BSHomeDataModelFrame)
        }
        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
        self.loadVideoUrl()
    }
    
}
