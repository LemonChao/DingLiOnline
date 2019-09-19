//
//  ZCGoodsDetailTableFooter.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/24.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsDetailTableFooter: ZCBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bottomLine = UIView(color: LineColor)
        
        self.addSubview(descriptButton)
        self.addSubview(noteButton)
        self.addSubview(bottomLine)
        self.addSubview(redLine)
        self.addSubview(scrollView)
        
        
        descriptButton.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH/2)
//            make.height.equalTo(FitWidth(48))
            make.height.equalTo(buttonHeight)
        }
        noteButton.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.size.equalTo(descriptButton)
        }
        redLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(descriptButton)
            make.centerX.equalTo(descriptButton)
            make.size.equalTo(CGSize(width: FitWidth(80), height: 2))
        }
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(descriptButton.snp_bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.8)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptButton.snp_bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadPages()  {
        self.addChildViewController()
    }
    
    func addChildViewController() {
        
        guard !scrollView.subviews.isEmpty else {
            let descriptVC = ZCGoodsDescriptVC()
            let noteVC = ZCGoodsNoteVC()
            let rect = scrollView.bounds
            
            descriptVC.view.frame = rect
            noteVC.view.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: rect.height)
            
//            scrollView.addSubview(descriptVC.view)
            scrollView.addSubview(noteVC.view)
//            self.viewController!.addChild(descriptVC)
            self.viewController!.addChild(noteVC)
            return
        }
    }
    
    lazy var descriptButton: UIButton = {
        let button = UIButton(title: "拍品描述", titleColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: UIColor.white)
        button.setTitleColor(GeneralRedColor, for: .selected)
        return button
    }()
    
    lazy var noteButton: UIButton = {
        let button = UIButton(title: "竞拍须知", titleColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: UIColor.white)
        button.setTitleColor(GeneralRedColor, for: .selected)
        return button
    }()
    
    let redLine = UIView(color: GeneralRedColor)
    
    lazy var scrollView: UIScrollView = {
        
        let view = UIScrollView(frame: CGRect.zero)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.bounces = false
//        view.contentSize = CGSize(width: SCREEN_WIDTH*2, height: SCREEN_HEIGHT-buttonHeight)
        
        return view
    }()
    
    let buttonHeight = NavBarHeight
    
}
