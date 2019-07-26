//
//  ZCCircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCCircleViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configCustomNav() {
        let view = UIView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: 44))
        view.backgroundColor = UIColor.cyan
        self.navigationController?.navigationBar.addSubview(view)
    }


}
