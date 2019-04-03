//
//  BSHomeTitleView.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit

protocol BSHomeTitleViewDelegate : NSObjectProtocol{
    func titleDidSelect(label: UILabel, index: Int)
}

class BSHomeTitleView: UIView {

    weak var delegate: BSHomeTitleViewDelegate?
    //标题数组
    var titles : Array<String>? {
        didSet{
            self.setupSubView()
        }
    }
   private var labelArray : Array<UILabel> = {
        let array = Array<UILabel>()
        return array
    }()
    
    var selectIndex : Int? {
        didSet {
            guard self.selectIndex! < self.labelArray.count else {
                return
            }
            
            let label = self.labelArray[self.selectIndex!]
            self.animateSelectLabel(label: label)
        }
    }
    private var selectLabel: UILabel?
    
    lazy var slider: UIView = { [unowned self] in
        let view = UIView.init(frame: CGRect.init(x: 0, y: 40, width: 20, height: 3.5))
        view.backgroundColor = ThemeColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        return view
    }()
    lazy var scrollView: UIScrollView = {
        let scrV = UIScrollView.init(frame: self.bounds)
        scrV.showsVerticalScrollIndicator = false
        scrV.showsHorizontalScrollIndicator = false
        return scrV
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectIndex = 0
        self.addSubview(self.scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BSHomeTitleView {
    
    func setupSubView() {
        
        guard self.titles?.isEmpty == false else {return}//titles为空直接return
        let count : CGFloat = CGFloat.init(self.titles!.count)
        var btnW : CGFloat = 60
        var contentWidth: CGFloat = btnW * count
        if contentWidth < self.width(){
            btnW = self.width()/count
            contentWidth = btnW * count
        }

        for (i, title) in (self.titles?.enumerated())! {
            let btnX = btnW*CGFloat.init(i)
            
            let label = UILabel.init(frame: CGRect.init(x: btnX, y: 0, width: btnW, height: 44))
            label.tag = i
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(labelClick))
            label.addGestureRecognizer(tap)
            
            label.textAlignment = NSTextAlignment.center
            label.text = title
            if i == selectIndex {
                label.textColor = UIColor.black
                self.selectLabel = label
            }else{
                label.textColor = UIColor.gray
            }

            self.addSubview(label)
            self.labelArray.append(label)
        }
        self.scrollView.contentSize = CGSize.init(width: contentWidth, height: 0)
        self.addSubview(self.slider)
    
        self.slider.center.x = self.selectLabel!.center.x
    }
    
    @objc func labelClick(tap : UITapGestureRecognizer)  {
        let label = tap.view as! UILabel
        self.animateSelectLabel(label: label)
        if self.delegate != nil{
            self.delegate?.titleDidSelect(label: label, index:label.tag)
        }
    }
    
    func animateSelectLabel(label: UILabel){
        self.selectLabel?.textColor = UIColor.gray
        label.textColor = UIColor.black
        self.selectLabel = label
        UIView.animate(withDuration: 0.25) {
            self.slider.center.x = label.center.x
        }
    }
}
