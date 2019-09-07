//
//  ZCBaseViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        self.configCustomNav()
        self.configViews()
        self.bindViewModel()
    }
    
    func configCustomNav() {}
    func configViews() {}
    func bindViewModel() {}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.bringSubviewToFront(customNavBar)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //控制StatusBar是否隐藏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //控制StatusBar显示模式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    //控制StatusBar动画方式
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.fade
    }
    
    lazy var customNavBar: ZCCustomNavigationBar = {
        let bar = ZCCustomNavigationBar(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: NavBarHeight))
        bar.setBackButton(withImage: UIImage(named: "back_black"))
        return bar
    }()
    
    
    deinit {
        print("\(String(describing: self)) deinit complete")
    }
}
