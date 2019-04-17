//
//  BSHomeSubCell.swift
//  BaiSi
//
//  Created by wzh on 2019/4/9.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit
import Kingfisher

protocol BSHomeSubCellDelegate : NSObjectProtocol{
    func imageViewDidClick(imageView: UIImageView, index: Int)
}

class BSHomeSubCell: UITableViewCell {

    lazy var iconView: UIImageView = { [unowned self] in
        let imagV = UIImageView.init()
        imagV.contentMode = UIView.ContentMode.scaleAspectFit
        return imagV
    }()
    
    lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    lazy var contentLabel: UILabel = { [unowned self] in
        let label = UILabel.init()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0)
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
    
    var index : Int = 0
    weak var delegate: BSHomeSubCellDelegate?

    
    
    
    var frameModel : BSHomeSubFrameModel? {
        
        didSet {
            iconView.frame = self.frameModel!.iconViewFrame!
            nameLabel.frame = self.frameModel!.nameFrame!
            contentLabel.frame = self.frameModel!.textLabelFrame!
            imgView.frame = self.frameModel!.imageViewFrame ?? CGRect.zero
            bottomBar.frame = self.frameModel!.bottomBarFrame!
            bottomLine.frame = self.frameModel!.bottomLineFrame!
            
            let model = self.frameModel?.model
            let iconUrl = URL.init(string: model!.profile_image!)
            
            let processor = RoundCornerImageProcessor(cornerRadius: 17.5)
            iconView.kf.setImage(
                with: iconUrl,
                placeholder: UIImage(named: "AppIcon"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .onlyLoadFirstFrame
                ])
            
            if model!.image0 != nil {
                let imageUrl = URL.init(string: model!.thumbnailImage!)
                
                let imgProcessor = RoundCornerImageProcessor(cornerRadius: 3.5)
                imgView.kf.setImage(
                    with: imageUrl,
                    placeholder: UIImage(named: "AppIcon"),
                    options: [
                        .processor(imgProcessor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }

            nameLabel.text = model?.name
            contentLabel.text = model?.text
            
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
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.bottomBar)
        self.contentView.addSubview(self.bottomLine)

    }
    
    @objc func imageViewTapClick(_ gestureRecognizer : UIGestureRecognizer){
        
            if self.delegate != nil {
                self.delegate?.imageViewDidClick(imageView: self.imgView, index: self.index)
            }
    }
}
