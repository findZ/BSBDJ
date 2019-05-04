//
//  BSHomeSubCell.swift
//  BaiSi
//
//  Created by wzh on 2019/4/9.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import SDWebImage

protocol BSHomeSubCellDelegate : NSObjectProtocol{
    func imageViewDidClick(imageView: UIImageView, indexPath: IndexPath)
    func videoViewDidClick(videoView: UIImageView, indexPath: IndexPath)
    func audioViewDidClick(audioView: UIImageView, indexPath: IndexPath)
    func iconViewDidClick(iconView: UIImageView, indexPath: IndexPath)

}

class BSHomeSubCell: UITableViewCell {

    lazy var iconView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 35, height: 35))
        imagV.circularBeadWithRadius(radius: 35/2.0)
        imagV.isUserInteractionEnabled = true
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(iconViewTapClick(_:)))
        imagV.addGestureRecognizer(singleTap)
        return imagV
    }()
    lazy var vipView: UIImageView = {
        let vip = UIImageView.init(image: UIImage.init(named: "tag_user_vip_icon"))
        vip.isHidden = true
        return vip
    }()
    lazy var gifIcon: UIImageView = {
        let imgV = UIImageView.init(image: UIImage.init(named: "common-gif_31x31"))
        imgV.isHidden = true
        return imgV
    }()

    lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    lazy var timeLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textAlignment = NSTextAlignment.left
        return label
        }()
    lazy var contentLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.numberOfLines = 0
//        label.backgroundColor = UIColor.randomColor()
        label.font = UIFont.pingFangSCRegular(size: 16.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    lazy var imgView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init()
        imagV.isUserInteractionEnabled = true
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(imageViewTapClick(_:)))
        imagV.addGestureRecognizer(singleTap)
        return imagV
    }()
    
    lazy var videoView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init()
        imagV.tag = 100
        imagV.backgroundColor = UIColor.black
        imagV.isUserInteractionEnabled = true
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(videoViewTapClick(_:)))
        imagV.addGestureRecognizer(singleTap)
        return imagV
    }()
    lazy var audioView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init()
        imagV.backgroundColor = UIColor.black
        imagV.isUserInteractionEnabled = true
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(audioViewTapClick(_:)))
        imagV.addGestureRecognizer(singleTap)
        var array = Array<UIImage>()
        for i in 0 ..< 8 {
            let img = UIImage.init(named: "showVoice-voice\(i+1)")
            array.append(img!)
        }
        imagV.animationImages = array
        imagV.animationDuration = 0.8
        imagV.animationRepeatCount = 0
        return imagV
    }()
    
    lazy var bottomBar: UIView = { [unowned self] in
        let v = UIView.init()
//        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    lazy var zanButton: UIButton = {
        let width = (Screen_width - 20)/4
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 35))
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(CommentColor, for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "mainCellDingN_23x23_"), for: UIControl.State.normal)
        return btn
    }()
    lazy var caiButton: UIButton = {
        let width = (Screen_width - 20)/4
        let btn = UIButton.init(frame: CGRect.init(x: width, y: 0, width: width, height: 35))
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(CommentColor, for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "mainCellCaiN_23x23_"), for: UIControl.State.normal)

        return btn
    }()
    lazy var shareButton: UIButton = {
        let width = (Screen_width - 20)/4
        let btn = UIButton.init(frame: CGRect.init(x: width*2, y: 0, width: width, height: 35))
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(CommentColor, for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "mainCellShareN_20x20_"), for: UIControl.State.normal)

        return btn
    }()
    lazy var commentButton: UIButton = {
        let width = (Screen_width - 20)/4
        let btn = UIButton.init(frame: CGRect.init(x: width*3, y: 0, width: width, height: 35))
        btn.isUserInteractionEnabled = false
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(CommentColor, for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "mainCellCommentN_20x20_"), for: UIControl.State.normal)
        
        return btn
    }()
    
    lazy var bottomLine: UIView = { [unowned self] in
        let v = UIView.init()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    
    var indexPath : IndexPath?
    weak var delegate: BSHomeSubCellDelegate?

    
    var frameModel : BSHomeDataModelFrame? {
        
        didSet {
            iconView.frame = self.frameModel!.iconViewFrame!
            vipView.frame = self.frameModel!.vipViewFrame!
            nameLabel.frame = self.frameModel!.nameFrame!
            timeLabel.frame = self.frameModel!.timeFrame!
            contentLabel.frame = self.frameModel!.textLabelFrame!
            imgView.frame = self.frameModel!.imageViewFrame ?? CGRect.zero
            videoView.frame = self.frameModel!.videoViewFrame ?? CGRect.zero
            audioView.frame = self.frameModel!.audioViewFrame ?? CGRect.zero
            bottomBar.frame = self.frameModel!.bottomBarFrame!
            bottomLine.frame = self.frameModel!.bottomLineFrame!
            
            guard let model = self.frameModel?.model else { return }
            self.setUpDataWithDataModel(model: model)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.setupSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    class func cellWithTableView(tableView : UITableView) -> BSHomeSubCell {
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

extension BSHomeSubCell {
    
    func setupSubView() {
        self.contentView.addSubview(self.iconView)
        self.contentView.addSubview(self.vipView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.videoView)
        self.contentView.addSubview(self.audioView)
        self.contentView.addSubview(self.bottomBar)
        self.contentView.addSubview(self.bottomLine)
        self.imgView.addSubview(self.gifIcon)
        self.bottomBar.addSubview(self.zanButton)
        self.bottomBar.addSubview(self.caiButton)
        self.bottomBar.addSubview(self.shareButton)
        self.bottomBar.addSubview(self.commentButton)

    }
    
    func setUpDataWithDataModel(model : BSHomeDataModel) {
        let iconUrl = URL.init(string: (model.u?.header!.last)!)
        iconView.sd_setImage(with: iconUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        
        var imageUrl = URL.init(string: "")
        self.gifIcon.isHidden = true

        switch model.type {
        case "video"://视频
            let video = model.video
            imageUrl = URL.init(string: (video?.thumbnail!.last)!)
            self.videoView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
            
            break
        case "image"://图片
            let image = model.image
            imageUrl = URL.init(string: (image?.thumbnail_small!.last)!)
            self.imgView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
            break
        case "gif"://gif图片
            self.gifIcon.isHidden = false
            let gif = model.gif
            imageUrl = URL.init(string: (gif?.gif_thumbnail!.last)!)
            self.imgView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
            break
        case "audio"://声音
            let audio = model.audio
            imageUrl = URL.init(string: (audio?.thumbnail!.last)!)
            self.audioView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
            if model.isPlayAudio == true {
                self.audioView.startAnimating()
            }else{
                self.audioView.stopAnimating()
            }
            break
        case "text"://段子
            break
            
        default:
            break
        }

        self.nameLabel.text = model.u?.name
        self.timeLabel.text = model.passtime
        self.contentLabel.text = model.text
        self.zanButton.setTitle(model.up, for: UIControl.State.normal)
        self.caiButton.setTitle(model.down, for: UIControl.State.normal)
        self.shareButton.setTitle(model.forward, for: UIControl.State.normal)
        self.commentButton.setTitle(model.comment, for: UIControl.State.normal)

        if model.u!.is_v! {
            self.vipView.isHidden = false
        }else{
            self.vipView.isHidden = true
        }
    }

    @objc func imageViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
        
            if self.delegate != nil {
                self.delegate?.imageViewDidClick(imageView: self.imgView, indexPath: self.indexPath!)
            }
    }
    
    @objc func videoViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
        
        if self.delegate != nil {
            self.delegate?.videoViewDidClick(videoView: self.videoView, indexPath: self.indexPath!)
        }
    }
    
    @objc func audioViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
        
        if self.delegate != nil {
            self.delegate?.audioViewDidClick(audioView: self.audioView, indexPath: self.indexPath!)
        }
    }
    @objc func iconViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
        
        if self.delegate != nil {
            self.delegate?.iconViewDidClick(iconView: self.iconView, indexPath: self.indexPath!)
        }
    }
}
