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
    
    
    /// 显示系统AlertView，最多一个button
    ///
    /// - Parameters:
    ///   - ViewController: 要显示的controller
    ///   - title: title
    ///   - message: message
    ///   - buttonTitle: button’s title， 为nil的话，没有button
    ///   - buttonStyle: button's style 为nil的话，没有button

    class func showWith(ViewController: UIViewController, title: String?, message: String?, buttonTitle: String?, buttonStyle:UIAlertAction.Style?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //添加按钮
        if let btnTitle = buttonTitle {
            
            let actionStyle = buttonStyle ?? UIAlertAction.Style.default
            let singleAction = UIAlertAction(title: btnTitle, style: actionStyle, handler: nil)
            
            alertController.addAction(singleAction)
            
        }else { // 没有按钮，设置自动消失
            self.perform(#selector(dismissAlertController(alert:)), with: alertController, afterDelay: AlertViewShowTime)
        }
        
        ViewController.present(alertController, animated: true, completion: nil)
    }
    
    /// 显示系统ActionSheet
    ///
    /// - Parameters:
    ///   - ViewController: 要显示的controller
    ///   - title: title
    ///   - message: message
    ///   - selectClosure: 选中每一个选项的回调(包括取消Action)，元组的形式返回Action.title,Action的下标。此处下标为最后一个可变参数对应的下标
    ///   - actions: 可变新式参数。Action‘s title,Action's style.建议如果有取消Action，放到最后一个比较合适
    class func showActionSheetWith(ViewController: UIViewController, title: String?, message: String?, selectClosure:@escaping (_ title: String, _ index: Int) -> Void, actions:(title: String, style:UIAlertAction.Style)...) {
        let sheetController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        for (index, item) in actions.enumerated() {
            
            let alertAction = UIAlertAction(title: item.title, style: item.style) { (action) in
                
                selectClosure(action.title!, index)
            }
            sheetController.addAction(alertAction)
        }
        
        ViewController.present(sheetController, animated: true, completion: nil)
    }
    
    
    
    @objc class func dismissAlertController(alert: UIAlertController) {
        alert.dismiss(animated: true, completion: nil)
    }
    
    
}
