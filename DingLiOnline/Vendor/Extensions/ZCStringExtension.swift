//
//  ZCStringExtension.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/13.
//  Copyright © 2019 leyukeji. All rights reserved.
//
#if os(OSX)
import AppKit
#endif

#if os(iOS) || os(tvOS)
import UIKit
#endif

extension String {
    
    /// 时间戳转 时间区间
    func timeInterval() -> String {
        
        
        
        return ""
    }
    
    
    
    /// 时间戳转时间字符串
    ///
    /// - Parameters:
    ///   - timestamp: 时间戳(second)
    ///   - formatterStr: 时间格式字符串
    /// - Returns: 时间
    public func time(frome timestamp: TimeInterval, formatterStr: String) -> String {
        
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = formatterStr
        let time = formatter.string(from: date)
        
        return time
    }
    
    func time(formatterStr: String) -> String {
        let date = Date(timeIntervalSince1970: Double(self) ?? NSTimeIntervalSince1970)
        let formatter = DateFormatter()
        formatter.dateFormat = formatterStr
        let time = formatter.string(from: date)
        
        return time
    }

    
    
    /// 时间戳转星期
    ///
    /// - Parameter timestamp: 时间戳(Double)
    /// - Returns: 星期几
    static func weekday(from timestamp: TimeInterval) -> String {
        
        let date = Date(timeIntervalSince1970: timestamp)
        let weekdays: [String] = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.day], from: date)
        
        return weekdays[theComponents.day!]
    }

    func weekday() -> String {
        
        let date = Date(timeIntervalSince1970: Double(self) ?? NSTimeIntervalSince1970)
        let weekdays: [String] = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.day], from: date)
        
        return weekdays[theComponents.day!-1]
    }

    
    
    
    
}
