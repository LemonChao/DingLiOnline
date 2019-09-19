//
//  ZCMySettingBusinessLicenseVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/17.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingBusinessLicenseVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "营业执照"
    }

}
