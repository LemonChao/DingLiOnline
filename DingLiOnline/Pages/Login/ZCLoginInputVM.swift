//
//  ZCLoginInputVM.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
class ZCLoginInputVM: NSObject {

    var phoneNumSignal: Signal<String, NoError>//接收用户名的信号
    var codeSignal: Signal<String, NoError>//接收验证码的信号
    var validSignal: Signal<Bool, NoError>//用户名和验证码是否合法的信号
    var loginAction: Action<(String, String), Bool, NoError>//登录的action
    
    init(_ phonesignal: Signal<String, NoError>, _ codesignal: Signal<String, NoError>) {
        phoneNumSignal = phonesignal
        codeSignal = codesignal
        
        //合并信号
        validSignal = Signal.combineLatest(phoneNumSignal, codeSignal).map{$0.count >= 5 && $1.count >= 6}
        
        //Property(首先接收一个初始的值)
        //根据合并的信号，创建控制登录按钮enable的属性
        let loginEnable = Property(initial: false, then: validSignal)
        
        // 登陆button状态和时间
        loginAction = Action(enabledIf: loginEnable, execute: { (number: String, code: String) -> SignalProducer<Bool, NoError> in
            return SignalProducer<Bool, NoError> { observe, disposable in
                
                let success = true
                
                //网络请求结果
                observe.send(value: success)
                observe.sendCompleted()
                
            }
        })
    }
    
    
}
