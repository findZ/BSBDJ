//
//  BSMineHeaderView.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/4.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import SDWebImage


class BSMineHeaderView: UIView {

    private let margin : CGFloat = 10.0
    private let bottomHeight : CGFloat = 50
    
    lazy var backgroundView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - bottomHeight))
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        return imagV
    }()
    
    lazy var iconView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init(frame: CGRect.init(x: margin, y: NAVIGATION_BAR_HEIGHT, width: 80, height: 80))
        imagV.circularBeadWithRadius(radius: 80/2.0)
        return imagV
    }()
    lazy var vipView: UIImageView = { [unowned self] in
        let vip = UIImageView.init(image: UIImage.init(named: "tag_user_vip_icon"))
        vip.frame = CGRect.init(x: self.iconView.frame.maxX-10, y: self.iconView.frame.maxY-10, width: 10, height: 10)
        vip.isHidden = true
        return vip
    }()
    
    lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel.init(frame: CGRect.init(x: margin, y: self.iconView.frame.maxY + margin, width: Screen_width - margin*2, height: 30))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    lazy var sexIcon: UIImageView = {
        let imgV = UIImageView.init(image: UIImage.init(named: "common-gif_31x31"))
        imgV.isHidden = true
        return imgV
    }()
    
    lazy var signatureLabel: UILabel = { [unowned self] in
        let label = UILabel.init(frame: CGRect.init(x: margin, y: self.nameLabel.frame.maxY, width: Screen_width - margin*2, height: 20))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    lazy var beffectView: UIVisualEffectView = { [unowned self] in
        //毛玻璃
        let beffect = UIBlurEffect(style: .dark)
        let beffectView = UIVisualEffectView.init(effect: beffect)
        beffectView.frame = self.backgroundView.bounds
        return beffectView
    }()
    lazy var bottomBar: UIView = { [unowned self] in
        let v = UIView.init(frame: CGRect.init(x: 0, y: self.backgroundView.frame.maxY, width: Screen_width, height: bottomHeight))
        v.backgroundColor = UIColor.white
        return v
    }()
    lazy var likeButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "获赞")
        btn.frame = CGRect.init(x: 0, y: 0, width: width, height: bottomHeight)
        return btn
    }()
    lazy var fansButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "粉丝")
        btn.frame = CGRect.init(x: width, y: 0, width: width, height: bottomHeight)
        return btn
    }()
    lazy var followButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "关注")
        btn.frame = CGRect.init(x: width*2, y: 0, width: width, height: bottomHeight)

        return btn
    }()
    lazy var levelButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "等级")
        btn.frame = CGRect.init(x: width*3, y: 0, width: width, height: bottomHeight)

        return btn
    }()
    
    lazy var bottomLine: UIView = { [unowned self] in
        let v = UIView.init(frame: CGRect.init(x: 0, y: self.bottomBar.frame.maxY - 0.8, width: Screen_width, height: 0.8))
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    
    var model : BSUserProfileModel? {
        didSet {
            let bgUrl = URL.init(string: model!.profile_image_large!)
            backgroundView.sd_setImage(with: bgUrl, completed: nil)
            let iconUrl = URL.init(string: model!.profile_image!)
            iconView.sd_setImage(with: iconUrl, completed: nil)
            
            nameLabel.text = model!.username
            signatureLabel.text = model!.introduction!.count > 0 ? model!.introduction : "这人很懒，什么都没写~"
            if model!.jie_v == "1" {
                self.vipView.isHidden = false
            }else{
                self.vipView.isHidden = true
            }
            self.setTextLabelData(text: model!.total_cmt_like_count!, btn: self.likeButton)
            self.setTextLabelData(text: model!.fans_count!, btn: self.fansButton)
            self.setTextLabelData(text: model!.follow_count!, btn: self.followButton)
            self.setTextLabelData(text: "LV\(model!.level!)", btn: self.levelButton)

        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.beffectView)
        self.addSubview(self.iconView)
        self.addSubview(self.vipView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.sexIcon)
        self.addSubview(self.signatureLabel)
        
        self.addSubview(self.bottomBar)
        self.bottomBar.addSubview(self.likeButton)
        self.bottomBar.addSubview(self.fansButton)
        self.bottomBar.addSubview(self.followButton)
        self.bottomBar.addSubview(self.levelButton)
        
        self.addSubview(self.bottomLine)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subButtonWithTitle(title: String) -> UIButton {
        let btn = UIButton.init()
//        btn.backgroundColor = UIColor.randomColor()
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 30, left: 0, bottom: 8, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.setTitleColor(CommentColor, for: UIControl.State.normal)
        btn.setTitle(title, for: UIControl.State.normal)
        
        let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: 8, width: Screen_width/4, height: 20))
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.tag = 19
        textLabel.textColor = UIColor.black
        textLabel.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addSubview(textLabel)
        
        return btn
    }
    
    func setTextLabelData(text: String , btn: UIButton) {
        let label = btn.viewWithTag(19) as! UILabel
        label.text = text
    }
    
}

