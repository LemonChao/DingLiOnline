//
//  ZCBindPhoneNumberVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCBindPhoneNumberVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bindInputView)
        
        bindInputView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(80))
            make.left.right.equalToSuperview().inset(FitWidth(24))
        }
    }
    
    @objc func okButtonAction(_ button: UIButton) {
        
    }
    
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.titleLabel.text = "绑定手机号"
    }

    let bindInputView = ZCLoginInputView(okButtonTitle: "确认绑定")
    
    
}
