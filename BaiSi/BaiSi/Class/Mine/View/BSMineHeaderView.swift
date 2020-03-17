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

    
    var bottomBarButtonDidlClick : ((UIButton) -> Void)?

    
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
        let imgV = UIImageView.init()
//        imgV.isHidden = true
//        imgV.backgroundColor = UIColor.randomColor()
        return imgV
    }()
    
    lazy var signatureLabel: UILabel = { [unowned self] in
        let label = UILabel.init(frame: CGRect.init(x: margin, y: self.nameLabel.frame.maxY, width: Screen_width - margin*2, height: 20))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    lazy var followButton: UIButton = { [unowned self] in
        let btn = UIButton.init(frame: CGRect.init(x: Screen_width - 80 - margin , y: NAVIGATION_BAR_HEIGHT + 30, width: 80, height: 40))
        btn.setTitle("关注", for: UIControl.State.normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = ThemeColor
        btn.isHidden = true
        return btn
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
        let btn = self.subButtonWithTitle(title: "获赞", tag:1)
        btn.frame = CGRect.init(x: 0, y: 0, width: width, height: bottomHeight)
        return btn
    }()
    lazy var fansButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "粉丝", tag:2)
        btn.frame = CGRect.init(x: width, y: 0, width: width, height: bottomHeight)
        return btn
    }()
    lazy var followCountButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "关注", tag:3)
        btn.frame = CGRect.init(x: width*2, y: 0, width: width, height: bottomHeight)

        return btn
    }()
    lazy var levelButton: UIButton = { [unowned self] in
        let width = Screen_width/4
        let btn = self.subButtonWithTitle(title: "等级", tag:4)
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
            iconView.sd_setImage(with: iconUrl, placeholderImage: UIImage.init(named: "avatar_m_70_70x70_"))
            
            let nameWidth = (model!.username?.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: 30), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)], context: nil).size.width)!
            self.nameLabel.frame = CGRect.init(x: margin, y: self.iconView.frame.maxY + margin, width: nameWidth, height: 30)
            if model!.sex == "m" {
                sexIcon.image = UIImage.init(named: "sex_men")
            }else if model!.sex == "w"{
                sexIcon.image = UIImage.init(named: "sex_women")
            }
            self.sexIcon.frame = CGRect.init(x:self.nameLabel.frame.maxX + margin, y: self.iconView.frame.maxY + margin + 5, width: 18, height: 18)
            nameLabel.text = model!.username
            signatureLabel.text = model!.introduction!.count > 0 ? model!.introduction : "这人很懒，什么都没写~"
            if model!.jie_v == "1" {
                self.vipView.isHidden = false
            }else{
                self.vipView.isHidden = true
            }
            if model!.id == "23069386" {
                self.followButton.isHidden = true
            }else{
                self.followButton.isHidden = false
            }
            
            if model!.relationship == "0" {
                self.followButton.setTitle("关注", for: UIControl.State.normal)
                self.followButton.backgroundColor = ThemeColor
            }else if model!.relationship == "2"{
                self.followButton.setTitle("已关注", for: UIControl.State.normal)
                self.followButton.backgroundColor = UIColor.gray
            }
            
            self.setTextLabelData(text: model!.total_cmt_like_count!, btn: self.likeButton)
            self.setTextLabelData(text: model!.fans_count!, btn: self.fansButton)
            self.setTextLabelData(text: model!.follow_count!, btn: self.followCountButton)
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
        self.addSubview(self.followButton)

        
        self.addSubview(self.bottomBar)
        self.bottomBar.addSubview(self.likeButton)
        self.bottomBar.addSubview(self.fansButton)
        self.bottomBar.addSubview(self.followCountButton)
        self.bottomBar.addSubview(self.levelButton)
        
        self.addSubview(self.bottomLine)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subButtonWithTitle(title: String ,tag: Int) -> UIButton {
        let btn = UIButton.init()
        btn.tag = tag
//        btn.backgroundColor = UIColor.randomColor()
        btn.titleEdgeInsets = UIEdgeInsets.init(top: 30, left: 0, bottom: 8, right: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.setTitleColor(CommentColor, for: UIControl.State.normal)
        btn.setTitle(title, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(buttonClick(_:)), for: UIControl.Event.touchUpInside)
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

extension BSMineHeaderView {
    
    @objc func buttonClick(_ button : UIButton){
        
        if self.bottomBarButtonDidlClick != nil {
            self.bottomBarButtonDidlClick!(button)
        }
    }
}

