//
//  ZCSubmitHuatiVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/21.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSubmitHuatiVC: ZCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "选择话题"
    }
    
    @objc func backButtonAction(_ button: UIButton) {
        if backCompleteEnclosure != nil {
            backCompleteEnclosure!("超哥的朋友圈")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /// vc返回时闭包回调传值
    public var backCompleteEnclosure: ((_ string: String) -> Void)?
}
