//
//  ZCCountDownButton.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/15.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCountDownButton: UIButton {
    
    /// 开始倒计时,如果正在进行，不做任何操作
    func startButtonWith(second aSecond: UInt,timeChanging:@escaping(_ button:ZCCountDownButton,_ time:UInt) -> String, finished:@escaping(_ button:ZCCountDownButton) -> String) {
        
        var totalTime = aSecond

        let timer = Timer.init(timeInterval: 1, repeats: true, block: { (timer) in
            
            totalTime -= 1
            self.isEnabled = totalTime <= 0
            if self.isEnabled { // 倒计时结束
                
                timer.invalidate()
                let title = finished(self)
                self.setTitle(title, for: .normal)
                self.setTitle(title, for: .disabled)
            }else {
                let title = timeChanging(self, totalTime)
                self.setTitle(title, for: .normal)
                self.setTitle(title, for: .disabled)
            }
        })
        
        timer.fireDate = Date.distantPast
        RunLoop.current.add(timer, forMode: .common)
    }


    
//    var timer: Timer!
    
    deinit {
        print("ZCCountDownButton---deinit")
    }
}
