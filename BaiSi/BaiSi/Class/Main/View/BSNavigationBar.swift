//
//  BSNavigationBar.swift
//  BaiSi
//
//  Created by wzh on 2019/4/30.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSNavigationBar: UIView {

    lazy var leftButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT, width: 60, height: 44))
//        btn.setTitle("返回", for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.pingFangSCRegular(size: 15.0)
        btn.setImage(UIImage.init(named: "capture_nav_back_normal"), for: UIControl.State.normal)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.setTitleColor(UIColor.withRGB(46, 123, 246), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.withRGBA(46, 123, 246, 0.7), for: UIControl.State.highlighted)
        return btn
    }()
    lazy var rightButton: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: Screen_width - 60.0, y: STATUS_BAR_HEIGHT, width: 60, height: 44))
        btn.titleLabel?.font = UIFont.pingFangSCRegular(size: 15.0)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        btn.setTitle("收藏", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.withRGB(46, 123, 246), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.withRGBA(46, 123, 246, 0.7), for: UIControl.State.highlighted)
        return btn
    }()
    lazy var imageView: UIImageView = {
        let imgView = UIImageView.init(frame: CGRect.init(x: 0, y: STATUS_BAR_HEIGHT + 4.5, width: 35, height: 35))
//        imgView.backgroundColor = UIColor.randomColor()
        imgView.center.x = Screen_width/2.0
        imgView.circularBeadWithRadius(radius: 35/2.0)
        return imgView
    }()
   private lazy var titleLabel: UILabel = { [unowned self] in
        let x = self.imageView.frame.maxX + 5.0
        let label = UILabel.init(frame: CGRect.init(x: x, y: STATUS_BAR_HEIGHT + 4.5, width: 60, height: 35))
//        label.backgroundColor = UIColor.randomColor()
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.pingFangSCRegular(size: 15.0)
        return label
    }()
    var title : String? {
        didSet{
            let maxWidth : CGFloat = Screen_width - 120 - 35
            
            let titleWidth = (self.title?.boundingRect(with: CGSize.init(width: maxWidth, height: 35.0), options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(size: 15.0)], context: nil).size.width)!
            let midWidth = Screen_width - 120
            
            let imgViewX : CGFloat = (midWidth - titleWidth - 35 - 5)/2 + 60
            
            self.imageView.frame = CGRect.init(x: imgViewX, y: 4.5 + STATUS_BAR_HEIGHT, width: 35, height: 35)
            let titleX = self.imageView.frame.maxX + 5

            self.titleLabel.frame = CGRect.init(x: titleX, y: 4.5 + STATUS_BAR_HEIGHT, width: titleWidth, height: 35.0)
            self.titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.leftButton)
        self.addSubview(self.rightButton)
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
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
