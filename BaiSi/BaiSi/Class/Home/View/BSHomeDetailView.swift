//
//  BSHomeDetailView.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import SDWebImage

class BSHomeDetailView: UIView {

    lazy var contentLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.numberOfLines = 0
        //        label.backgroundColor = UIColor.randomColor()
        label.font = UIFont.pingFangSCRegular(size: 16.0)
        label.textAlignment = NSTextAlignment.left
        return label
        }()

    lazy var contentView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init()
        imagV.tag = 200
        imagV.backgroundColor = UIColor.black
        imagV.isUserInteractionEnabled = true
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(contentViewTapClick(_:)))
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
    var frameModel : BSHomeDetailHeaderFrameModel? {
        didSet {
            self.contentLabel.frame = self.frameModel!.contentLabelFrame!
            guard let model = self.frameModel?.model else { return }

            self.contentLabel.text = model.text
            
            var imageUrl = URL.init(string: "")

            switch model.type {
            case "video":
                imageUrl = URL.init(string: (model.video?.thumbnail!.last)!)!
                break
            case "audio":
                imageUrl = URL.init(string: (model.audio?.thumbnail!.last)!)!
                break
            case "image":
                imageUrl = URL.init(string: (model.image?.big!.last)!)!
                break
            case "gif":
                imageUrl = URL.init(string: (model.gif?.images!.last)!)!
                break
            default:
                break
            }

            if model.type != "text" {
                self.contentView.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
                self.contentView.frame = self.frameModel!.contentViewFrame!
            }
            self.bottomBar.frame = self.frameModel!.bottomBarFrame!
            self.bottomLine.frame = self.frameModel!.bottomLineFrame!
            if model.isPlayAudio == true {
                contentView.startAnimating()
            }
            self.zanButton.setTitle(model.up, for: UIControl.State.normal)
            self.caiButton.setTitle(model.down, for: UIControl.State.normal)
            self.shareButton.setTitle(model.forward, for: UIControl.State.normal)
            self.commentButton.setTitle(model.comment, for: UIControl.State.normal)
        }
    }
    
    var contentViewDidClick : ((BSHomeDataModel, UIImageView) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.contentLabel)
        self.addSubview(self.contentView)
        self.addSubview(self.bottomLine)
        self.addSubview(self.bottomBar)
        self.bottomBar.addSubview(self.zanButton)
        self.bottomBar.addSubview(self.caiButton)
        self.bottomBar.addSubview(self.shareButton)
        self.bottomBar.addSubview(self.commentButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BSHomeDetailView {
    @objc func contentViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
    
        if self.contentViewDidClick != nil{
            self.contentViewDidClick!(self.frameModel!.model!, self.contentView)
        }
    }
}
