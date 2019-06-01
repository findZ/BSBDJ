//
//  BSPersonalAttentionCell.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/6/1.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

class BSPersonalAttentionCell: UITableViewCell {
    
    lazy var iconView: UIImageView = {
        let imagV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 40, height: 40))
        imagV.circularBeadWithRadius(radius: 40/2.0)
        imagV.isUserInteractionEnabled = true
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
//        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(iconViewTapClick(_:)))
//        imagV.addGestureRecognizer(singleTap)
        return imagV
    }()

    lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel.init(frame: CGRect.init(x: 60, y: 10, width: Screen_width - 70, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textAlignment = NSTextAlignment.left
        return label
        }()
    lazy var infoLabel: UILabel = { [unowned self] in
        let label = UILabel.init(frame: CGRect.init(x: 60, y: 35, width: Screen_width - 70, height: 13))
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = NSTextAlignment.left
        label.text = "这家伙很懒，神马都木有写！！！"
        return label
        }()
    lazy var bottomLine: UIView = { [unowned self] in
        let v = UIView.init(frame: CGRect.init(x: 0, y: 59.2, width: Screen_width, height: 0.8))
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
        }()

    var model : BSPersonalAttentionModel? {
        
        didSet {
            self.nameLabel.text = self.model?.username
            if self.model?.introduction?.count != 0 {
                self.infoLabel.text = self.model?.introduction
            }else{
                self.infoLabel.text = "这家伙很懒，神马都木有写！！！"

            }

            let url = URL.init(string: (self.model?.profile_image!)!)
            self.iconView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "avatar_m_70_70x70_"))
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.iconView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.infoLabel)
        self.addSubview(self.bottomLine)

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(tableView : UITableView) -> BSPersonalAttentionCell {
        let identifier = "BSPersonalAttentionCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell != nil {
            return cell as! BSPersonalAttentionCell
        }else {
            cell = BSPersonalAttentionCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: identifier)
        }
        return cell as! BSPersonalAttentionCell
    }
    
    

}
