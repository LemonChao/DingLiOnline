//
//  ZCAddressAddVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/26.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCAddressAddVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "添加收货地址"
    }

    
    /// 重写button事件，拦截
    @objc func backButtonAction(_ button: UIButton) {
        if backCompleteEnclosure != nil {
            backCompleteEnclosure!("超哥的朋友圈")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /// vc返回时闭包回调传值
    public var backCompleteEnclosure: ((_ string: String) -> Void)?

    
    
}
