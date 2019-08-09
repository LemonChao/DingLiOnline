//
//  ZCCustomNavigationBar.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/9.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCustomNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: NavBarHeight))
        self.backgroundColor = UIColor.white
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(rightButton)
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(StatusBarHeight)
            make.height.equalTo(44)
            make.width.lessThanOrEqualTo(44)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(StatusBarHeight)
            make.left.equalTo(backButton.snp_right).offset(10)
            make.right.equalTo(rightButton.snp_left).offset(-10)
            make.height.equalTo(44)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(StatusBarHeight)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonAction(_ button: UIButton) {
        
    }
    
    
    @objc func rightButtonAction(_ button: UIButton)  {
        
        if let vc = self.viewController() {
            if vc.responds(to: #selector(rightButtonAction(_:))) {
                vc.perform(#selector(rightButtonAction(_:)), with: button)
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.setContentHuggingPriority(.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    
}
