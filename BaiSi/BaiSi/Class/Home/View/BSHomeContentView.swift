//
//  BSHomeContentView.swift
//  BaiSi
//
//  Created by wzh on 2019/4/3.
//  Copyright © 2019 wzh. All rights reserved.
//

import UIKit


protocol BSHomeContentViewDelegate : NSObjectProtocol {
    func contentViewDidScroll(index: Int)
    func contentViewDidEndScroll(index: Int)
}

class BSHomeContentView: UIView {

    weak var delegate : BSHomeContentViewDelegate?
    var isDragging = false
    
    var contentArray: Array<UIView>? {
        didSet{
            self.setupSubView()
        }
    }
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let scrV = UIScrollView.init(frame: self.bounds)
        scrV.showsVerticalScrollIndicator = false
        scrV.showsHorizontalScrollIndicator = false
        scrV.isPagingEnabled = true
        scrV.delegate = self
        return scrV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToIndexPage(index: Int){
        self.isDragging = false
        self.scrollView.setContentOffset(CGPoint.init(x: self.width()*CGFloat.init(index), y: 0), animated: true)
    }
    
}

extension BSHomeContentView {
    func setupSubView(){
        
        guard self.contentArray?.isEmpty != true else {
            return//contentArray为空时
        }
        let width = self.width()
        let height = self.height()
        let count = self.contentArray!.count
        
        for (i, subView) in self.contentArray!.enumerated(){
            
            subView.frame = CGRect.init(x: width*CGFloat.init(i), y: 0, width: width, height: height)
            self.scrollView.addSubview(subView)
        }
        self.scrollView.contentSize = CGSize.init(width: width*CGFloat.init(count), height: 0)
    }
}

extension BSHomeContentView : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isDragging = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.isDragging == true {
            if self.delegate != nil  {
                let index = roundf(Float(scrollView.contentOffset.x/scrollView.bounds.size.width))
                self.delegate?.contentViewDidScroll(index: Int(index))
            }            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.isDragging = false
        if self.delegate != nil {
            let index = roundf(Float(scrollView.contentOffset.x/scrollView.bounds.size.width))
            self.delegate?.contentViewDidEndScroll(index: Int(index))
        }
    }
}


