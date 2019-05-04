//
//  BSNavigationBar.swift
//  BaiSi
//
//  Created by wzh on 2019/4/30.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSNavigationBar: UIView {

    var isHiddenHeaderView : Bool = false {
        didSet {
            self.headerView.isHidden = isHiddenHeaderView
            if self.isHiddenHeaderView {
                self.leftButton.imageView?.tintColor = UIColor.white
            }else{
                self.leftButton.imageView?.tintColor = UIColor.withRGB(82, 82, 82)
            }
        }
    }
    lazy var leftButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: btnWidth, height: 44))
//        btn.setTitle("返回", for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.pingFangSCRegular(size: 15.0)
        let img = UIImage(named: "capture_nav_back_normal")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        btn.setImage(img, for: UIControl.State.normal)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.setTitleColor(UIColor.withRGB(46, 123, 246), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.withRGBA(46, 123, 246, 0.7), for: UIControl.State.highlighted)
        btn.imageView?.tintColor = UIColor.withRGB(82, 82, 82)

        return btn
    }()
    lazy var rightButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: Screen_width - btnWidth, y: STATUS_BAR_HEIGHT, width: btnWidth, height: 44))
        btn.titleLabel?.font = UIFont.pingFangSCRegular(size: 15.0)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        btn.setTitle("收藏", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.withRGB(46, 123, 246), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.withRGBA(46, 123, 246, 0.7), for: UIControl.State.highlighted)
        btn.isHidden = true

        return btn
    }()
    lazy var imageView: UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT + 4.5, width: 35, height: 35))
//        imgView.backgroundColor = UIColor.randomColor()
        imgView.center.x = Screen_width/2.0
        imgView.circularBeadWithRadius(radius: 35/2.0)
        return imgView
    }()
    lazy var vipView: UIImageView = {
        let vip = UIImageView.init(image: UIImage.init(named: "tag_user_vip_icon"))
        vip.isHidden = true
        return vip
    }()
    lazy var titleLabel: UILabel = { [unowned self] in
        let x = self.imageView.frame.maxX + 5.0
        let label = UILabel.init(frame: CGRect.init(x: x, y: STATUS_BAR_HEIGHT + 4.5, width: 60, height: 35))
//        label.backgroundColor = UIColor.randomColor()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.pingFangSCRegular(size: 15.0)
        return label
    }()
   private lazy var headerView: UIView = {
        let hv = UIView.init()
        return hv
    }()
    private let btnWidth : CGFloat = 60
    var title : String? {
        didSet{
            let maxWidth : CGFloat = Screen_width - 120 - 35
            
            let titleWidth = (self.title?.boundingRect(with: CGSize.init(width: maxWidth, height: 35.0), options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(size: 15.0)], context: nil).size.width)!
            let midWidth = Screen_width - btnWidth * 2
            
            let headerViewX = (midWidth - titleWidth - 35 - 5)/2 + btnWidth
            let headerViewWidth = headerViewX + titleWidth + 5
            self.headerView.frame = CGRect.init(x: headerViewX, y: 4.5 + STATUS_BAR_HEIGHT, width: headerViewWidth, height: 35)
            
            self.imageView.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35)
            let titleX = self.imageView.frame.maxX + 5
            
            self.titleLabel.frame = CGRect.init(x: titleX, y: 0, width: titleWidth, height: 35.0)
            self.titleLabel.text = title
            self.vipView.frame = CGRect.init(x: self.imageView.frame.maxX - 10, y: self.imageView.frame.maxY - 10, width: 10, height: 10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.leftButton)
        self.addSubview(self.rightButton)
        self.addSubview(self.headerView)
        self.headerView.addSubview(self.imageView)
        self.headerView.addSubview(self.titleLabel)
        self.headerView.addSubview(self.vipView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension BSNavigationBar {
    
    
}
