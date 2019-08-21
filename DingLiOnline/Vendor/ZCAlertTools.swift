//
//  ZCAlertTools.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/21.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCAlertTools: NSObject {
    static let AlertViewShowTime = 1.0
    
    
    class func showWith(ViewCOntroller: UIViewController, title: String?, message: String?, buttonTitle: String?, buttonStyle:UIAlertAction.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //添加按钮
        if let btnTitle = buttonTitle {
            
            let singleAction: UIAlertAction!
            switch buttonStyle {
            case .default:
                singleAction = UIAlertAction(title: btnTitle, style: .default, handler: nil)
                
            case .cancel:
                singleAction = UIAlertAction(title: btnTitle, style: .cancel, handler: nil)
                
            case .destructive:
                singleAction = UIAlertAction(title: btnTitle, style: .destructive, handler: nil)
                
            @unknown default:
                singleAction = UIAlertAction(title: btnTitle, style: .default, handler: nil)
            }
            
            alertController.addAction(singleAction)
            
        }else { // 没有按钮，设置自动消失
            self.perform(#selector(dismissAlertController(alert:)), with: alertController, afterDelay: AlertViewShowTime)
        }
        
        ViewCOntroller.present(alertController, animated: true, completion: nil)
    }
    
    
    @objc class func dismissAlertController(alert: UIAlertController) {
        alert.dismiss(animated: true, completion: nil)
    }
    
    
}
