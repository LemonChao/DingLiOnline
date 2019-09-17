//
//  ZCMySettingServiceAgreementVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/17.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingServiceAgreementVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "服务协议"
    }


}
