//
//  ZCSubmitCircleVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/13.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSubmitCircleVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "创建圈子"
        customNavBar.setRightButton(withTitle: "发布", color: GeneralRedColor)
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
        
        let image = UIImage(named: "IMG_2852")
        
        
        
        NetworkHelper.postRequestWith(url: kaddCircle, params: ["":""], success: { (response) in
            
        }) { (error) in
            
        }
    }
    
    
    
    
    
}
