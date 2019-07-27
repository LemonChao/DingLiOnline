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

        // Do any additional setup after loading the view.
    }
    
    override func configCustomNav() {
        let cusNaviBar = ZCCircleNavigationBar(frame: CGRect(x: (SCREEN_WIDTH-150)/2, y: 0, w: 150, h: 44), parent:self)
        cusNaviBar.contentViewHeight = Double(SCREEN_HEIGHT) - NavBarHeight - TabBarHeight
        cusNaviBar.titles = ["关注","圈子","我的"]
        cusNaviBar.viewControllers = [ZCFocusViewController(),ZCMycircleViewController(),ZCTopicListViewController()]

        cusNaviBar.parentViewController = self
        cusNaviBar.delegate = self
        cusNaviBar .reloadPages()
        self.navigationController?.navigationBar.addSubview(cusNaviBar)
    }


}
