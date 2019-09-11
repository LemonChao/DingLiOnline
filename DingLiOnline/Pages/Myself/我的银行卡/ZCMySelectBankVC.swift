//
//  ZCMySelectBankVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/11.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySelectBankVC: ZCBaseViewController {

    override func configCustomNav() {
        self.view.addSubview(customNavBar)
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
