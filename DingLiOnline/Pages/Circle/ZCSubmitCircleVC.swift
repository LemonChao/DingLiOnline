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
        
        let image = UIImage(named: "IMG_3254.jpg")
        
        QiniuTools.sharedInstance.uploadImageData(image: (image?.pngData())!) { (progress, imageKey) in
            print("progress:\(String(describing: progress))  key:\(imageKey)")
        }
        
//        QiniuTools.uploadVideoData(<#T##QiniuTools#>)
        
        NetworkHelper.postRequestWith(url: kaddCircle, params: ["":""], success: { (response) in

        }) { (error) in

        }
        
    }
    
    
    
    
    
}
