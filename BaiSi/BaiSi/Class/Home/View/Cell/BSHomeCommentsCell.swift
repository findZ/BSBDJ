//
//  BSHomeCommentsCell.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import SDWebImage

protocol BSHomeCommentsCellDelegate : NSObjectProtocol{
    func iconViewDidClick(iconView: UIImageView, indexPath: IndexPath)
    
}


class BSHomeCommentsCell: UITableViewCell {

    var delegate : BSHomeCommentsCellDelegate?
    
    lazy var iconView: UIImageView = {
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
    lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.font = UIFont.pingFangSCRegular(size: 14.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    lazy var contentLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.numberOfLines = 0
        //        label.backgroundColor = UIColor.randomColor()
        label.font = UIFont.pingFangSCRegular(size: 15.0)
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
    lazy var line: UIView = { [unowned self] in
        let v = UIView.init()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    
    var indexPath : IndexPath?

    
    var frameModel : BSHomeCommentFrameModel? {
        didSet {
            guard let user = frameModel!.model!.user else {
                return
            }
            let url = URL.init(string: user.profile_image!)
            self.iconView.sd_setImage(with: url, completed: nil)
            self.nameLabel.text = user.username
            self.contentLabel.text = frameModel!.model!.content
            self.timeLabel.text = frameModel!.model!.ctime
            
            self.iconView.frame = frameModel!.iconViewFrame!
            self.vipView.frame = frameModel!.iconViewFrame!
            self.nameLabel.frame = frameModel!.nameLabelFrame!
            self.contentLabel.frame = frameModel!.contentLabelFrame!
            self.timeLabel.frame = frameModel!.timeLabelFrame!

            self.line.frame = frameModel!.lineFrame!
            if frameModel!.model!.user!.is_vip! {
                self.vipView.isHidden = false
            }else{
                self.vipView.isHidden = true
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.iconView)
        self.addSubview(self.vipView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.timeLabel)
        self.addSubview(self.line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(tableView : UITableView) -> BSHomeCommentsCell {
        let identifier = "BSHomeCommentsCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell != nil {
            return cell as! BSHomeCommentsCell
        }else {
            cell = BSHomeCommentsCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: identifier)
        }
        return cell as! BSHomeCommentsCell
    }

}

extension BSHomeCommentsCell {
    @objc func iconViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
        
        if self.delegate != nil {
            self.delegate?.iconViewDidClick(iconView: self.iconView, indexPath: self.indexPath!)
        }
    }
}
