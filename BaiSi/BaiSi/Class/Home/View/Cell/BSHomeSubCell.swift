//
//  BSHomeSubCell.swift
//  BaiSi
//
//  Created by wzh on 2019/4/9.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import SDWebImage
import ZFPlayer

protocol BSHomeSubCellDelegate : NSObjectProtocol{
    func imageViewDidClick(imageView: UIImageView, indexPath: IndexPath)
    func videoViewDidClick(videoView: UIImageView, indexPath: IndexPath)
    func audioViewDidClick(audioView: UIImageView, indexPath: IndexPath)
}

class BSHomeSubCell: UITableViewCell {

    lazy var iconView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 35, height: 35))
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: 35/2.0, y: 35/2.0), radius: 35/2.0, startAngle: 0, endAngle: .pi*2, clockwise: true)
        let layer = CAShapeLayer.init()
        layer.frame = imagV.bounds
        layer.path = path.cgPath
        imagV.layer.mask = layer
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        return imagV
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
        label.font = UIFont.systemFont(ofSize: 16.0)
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
    
    lazy var bottomLine: UIView = { [unowned self] in
        let v = UIView.init()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    
    var indexPath : IndexPath?
    weak var delegate: BSHomeSubCellDelegate?

    
    var frameModel : BSHomeSubFrameModel? {
        
        didSet {
            iconView.frame = self.frameModel!.iconViewFrame!
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
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.videoView)
        self.contentView.addSubview(self.audioView)
        self.contentView.addSubview(self.bottomBar)
        self.contentView.addSubview(self.bottomLine)

    }
    
    func setUpDataWithDataModel(model : BSHomeSubModel) {
        let iconUrl = URL.init(string: model.profile_image!)
        iconView.sd_setImage(with: iconUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        
        if model.image0 != nil {
            let imageUrl = URL.init(string: model.thumbnailImage!)
            switch model.type {
            case "41"://视频
                self.videoView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
                
                break
            case "10"://图片
                self.imgView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
                
                break
            case "31"://声音
                self.audioView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
                if model.isPlayAudio == true {
                    self.audioView.startAnimating()
                }else{
                    self.audioView.stopAnimating()
                }
                break
            case "29"://段子
                break
                
            default:
                break
            }
        }
        self.nameLabel.text = model.name
        self.timeLabel.text = model.passtime
        self.contentLabel.text = model.text
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
}
