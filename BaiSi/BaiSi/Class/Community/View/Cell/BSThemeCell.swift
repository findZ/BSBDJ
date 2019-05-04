//
//  BSThemeCell.swift
//  BaiSi
//
//  Created by wangzhaohui-Mac on 2019/5/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import SDWebImage

class BSThemeCell: UITableViewCell {

    lazy var imgView: UIImageView = {
        let imgV = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 60, height: 60))
        imgV.circularBeadWithRadius(radius: 5)
        return imgV
    }()
    
    lazy var nameLabel: UILabel = { [unowned self] in
        let x = self.imgView.frame.maxX + 10
        let width = Screen_width - x
        let label = UILabel.init(frame: CGRect.init(x:x , y: 15, width: width, height: 20))
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = NSTextAlignment.left
        return label
        }()
    lazy var infoLabel: UILabel = { [unowned self] in
        let x = self.imgView.frame.maxX + 10
        let width = Screen_width - x - 10
        let label = UILabel.init(frame: CGRect.init(x: x, y: self.nameLabel.frame.maxY + 5, width: width, height: 20))
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    lazy var line: UIView = {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 79.5, width: Screen_width, height: 0.5))
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    var model : BSThemeModel? {
        didSet {
            self.imgView.sd_setImage(with: URL.init(string: self.model!.image_list!), completed: nil)
            self.nameLabel.text = self.model!.theme_name
            self.infoLabel.text = self.model?.info

        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.infoLabel)
        self.contentView.addSubview(self.line)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    class func cellWithTableView(tableView : UITableView) -> BSThemeCell {
        let identifier = "BSThemeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell != nil {
            return cell as! BSThemeCell
        }else {
            cell = BSThemeCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: identifier)
        }
        return cell as! BSThemeCell
    }

}
