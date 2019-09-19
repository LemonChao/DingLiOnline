//
//  ZCBaseNavigationController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // no: 解决scrollView 往上偏移
        self.navigationBar.isTranslucent = false;
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // 状态栏style 交给内部vc控制
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    // 状态栏hidden 交给内部vc控制
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
}
