//
//  ZCSubmitQuanxianVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/21.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSubmitQuanxianVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "谁可以看"
    }

    @objc func backButtonAction(_ button: UIButton) {
        if backCompleteEnclosure != nil {
            backCompleteEnclosure!("私密")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    /// vc返回时闭包回调传值
    public var backCompleteEnclosure: ((_ string: String) -> Void)?

    
}
