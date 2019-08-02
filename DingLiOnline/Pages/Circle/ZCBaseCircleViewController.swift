//
//  ZCBaseCircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCBaseCircleViewController: ZCBaseViewController {

    lazy var publishButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_publish"), for: .normal)
        button.setImage(UIImage(named: "circle_publish"), for: .highlighted)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(publishButton)
        publishButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(FitWidth(20))
        }
        
    }
    
    override func configCustomNav() {
        let cusNaviBar = ZCCircleNavigationBar(frame: CGRect(x: (SCREEN_WIDTH-182)/2, y: 0, w: 182, h: 44), parent:self)
        cusNaviBar.contentViewHeight = SCREEN_HEIGHT - NavBarHeight - TabBarHeight
        cusNaviBar.titles = ["关注","圈子","我的"]
        cusNaviBar.viewControllers = [ZCFocusViewController(),ZCCircleViewController(),ZCMycircleViewController()]
        cusNaviBar.parentViewController = self
        cusNaviBar.delegate = self
        cusNaviBar .reloadPages()
        
        let rightNaviItem = UIBarButtonItem.init(image: UIImage(named: "circle_topic"), style: .plain, target: self, action: #selector(rightNaviItemAction(item:)))
        self.navigationItem.setRightBarButton(rightNaviItem, animated: false)
        self.navigationController?.navigationBar.addSubview(cusNaviBar)
    }

    
    @objc func rightNaviItemAction(item: UIBarButtonItem) {
        
    }

}


extension ZCBaseCircleViewController: ZCCircleNavigationBarDelegate {
    
    func circleNavigationBarSelectAt(_ index: Int) {
        publishButton.isHidden = index == 2
    }
    
}

