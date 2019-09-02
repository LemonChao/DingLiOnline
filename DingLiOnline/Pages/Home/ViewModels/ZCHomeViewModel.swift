//
//  ZCHomeViewModel.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ZCHomeViewModel: ZCBaseViewModel {
    
    var model: ZCHomeModel?
    
    
    //1. 闭包里面要用到 self，要用懒加载方式创建属性 reason:  lazy可以确保一个成员只能在类对象在完整初始化过以后,才能使用
    lazy var netAction: Action = { () -> Action<(), Bool, Error> in
        
        // Initializes an `Action` that would always be enabled.如果外面 apply ,则会立即执行
        // 这里不需要参数 (string: String) -> SignalProducer<Bool, Error> 可以省略
        let action = Action { () -> SignalProducer<Bool, Error> in
            //通过SignalProducer.init(startHandler: (Signal<-,->.Observer, Lifetime) -> Void)创建SignalProducer
            return SignalProducer<Bool, Error> { observer, lifeTime in
                // 1.
                lifeTime.observeEnded {
                    print("信号无效了 你可以在这里进行一些清理工作")
                }
                
                //2. 网络请求
                NetworkHelper.postRequestWith(url: khomeIndex, params: nil, success: { (response) in
                    // 2.向外界发送事件
                    if response["result"].intValue == 1 {
                        self.model = ZCHomeModel.init(json: response["data"])
                        observer.send(value: true)
                    }else {
                        
//                        let error = Error("第三方")
//                        
//                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                    
                }, failed: { (error) in
                    observer.send(error: error)
                })
                
                
            }
        }
        return action
    }()

    
    
    
//    // Initializes an `Action` that would always be enabled.如果外面 apply ,则会立即执行
//    // 这里不需要参数 (string: String) -> SignalProducer<Bool, Error> 可以省略
//    var netAction = Action { () -> SignalProducer<Bool, Error> in
//        //通过SignalProducer.init(startHandler: (Signal<-,->.Observer, Lifetime) -> Void)创建SignalProducer
//        return SignalProducer<Bool, Error> { observer, lifeTime in
//            // 1.
//            lifeTime.observeEnded {
//                print("信号无效了 你可以在这里进行一些清理工作")
//            }
//            NetworkHelper.postRequestWith(url: khomeIndex, params: nil, success: { (response) in
//                // 2.向外界发送事件
//                if response["result"].intValue == 1 {
//                    self.model = ZCHomeModel.init(json: response["data"])
//                    observer.send(value: true)
//                }
//
//
//                observer.sendCompleted()
//
//            }, failed: { (error) in
//                observer.send(error: error)
//            })
//
//
//
//
//
//        }
//
//
//    }

    
    
 /// example [unowned self]
    
//    var name: String!
//    var text: String?
//    lazy var asHTML: () -> String = {
//        // Capture list
//        [unowned self /*, other capture member*/] () -> String in
//        if let text = self.text {
//            return "<\(self.model)>\(self.text)"
//        } else {
//            return "<\(self.name)>"
//        }
//    }
}
