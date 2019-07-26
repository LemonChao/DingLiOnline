//
//  ZCBaseTabBarController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCBaseTabBarController: UITabBarController {

    lazy var homeNav: ZCBaseNavigationController = {
        let vc = ZCHomeViewController()
        let nav = ZCBaseNavigationController.init(rootViewController: vc)
        nav.tabBarItem = UITabBarItem.init(title: "首页", image: UIImage(named: "home_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home_select")?.withRenderingMode(.alwaysOriginal))
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:NormalColor], for: .normal)
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:PrimaryColor], for: .selected)
       return nav
    }()
    
    lazy var classifyNav: ZCBaseNavigationController = {
        let vc = ZCClassifyViewController()
        let nav = ZCBaseNavigationController.init(rootViewController: vc)
        nav.tabBarItem = UITabBarItem.init(title: "分类", image: UIImage(named: "classify_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "classify_select")?.withRenderingMode(.alwaysOriginal))
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:NormalColor], for: .normal)
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:PrimaryColor], for: .selected)
        return nav
    }()

    lazy var circleNav: ZCBaseNavigationController = {
        let vc = ZCCircleViewController()
        let nav = ZCBaseNavigationController.init(rootViewController: vc)
        nav.tabBarItem = UITabBarItem.init(title: "圈子", image: UIImage(named: "circle_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "circle_select")?.withRenderingMode(.alwaysOriginal))
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:NormalColor], for: .normal)
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:PrimaryColor], for: .selected)
        return nav
    }()

    lazy var myselfNav: ZCBaseNavigationController = {
        let vc = ZCMyselfViewController()
        let nav = ZCBaseNavigationController.init(rootViewController: vc)
        nav.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage(named: "myself_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "myself_select")?.withRenderingMode(.alwaysOriginal))
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:NormalColor], for: .normal)
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:PrimaryColor], for: .selected)
        return nav
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [self.homeNav,self.classifyNav,self.circleNav,self.myselfNav]
        self.tabBar.backgroundImage = UIImage.imageColor(UIColor.white)
    }
}
