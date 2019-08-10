//
//  ZCBaseCircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCBaseCircleViewController: ZCBaseViewController {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(publishButton)
        publishButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(FitWidth(20))
        }
        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.setBackButton(withImage: UIImage())
        customNavBar.setRightButton(withImage: UIImage(named: "circle_topic"))
        
        let cusNaviBar = ZCCircleNavigationBar(frame: CGRect(x: (SCREEN_WIDTH-182)/2, y: StatusBarHeight, w: 182, h: 44), parent:self)
        cusNaviBar.contentViewHeight = SCREEN_HEIGHT - NavBarHeight - TabBarHeight
        cusNaviBar.titles = ["关注","圈子","我的"]
        cusNaviBar.viewControllers = [ZCFocusViewController(),ZCCircleViewController(),ZCMycircleViewController()]
        cusNaviBar.parentViewController = self
        cusNaviBar.delegate = self
        cusNaviBar .reloadPages()

        self.customNavBar.addSubview(cusNaviBar)
        
    }

    
    @objc func rightButtonAction(button: UIButton) {
        
    }
    
    lazy var publishButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_publish"), for: .normal)
        button.setImage(UIImage(named: "circle_publish"), for: .highlighted)
        return button
    }()

    
}


extension ZCBaseCircleViewController: ZCCircleNavigationBarDelegate {
    
    func circleNavigationBarSelectAt(_ index: Int) {
        publishButton.isHidden = index == 2
    }
    
}

