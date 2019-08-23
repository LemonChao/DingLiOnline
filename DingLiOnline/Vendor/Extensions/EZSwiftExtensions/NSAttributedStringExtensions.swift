//
//  NSAttributedStringExtensions.swift
//  EZSwiftExtensions
//
//  Created by Lucas Farah on 18/02/16.
//  Copyright (c) 2016 Lucas Farah. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

extension NSAttributedString {
    /// EZSE: Adds bold attribute to NSAttributedString and returns it

    #if os(iOS)

    public func bold() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)//UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }

    #endif

    /// EZSE: Adds underline attribute to NSAttributedString and returns it
    public func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        return copy
    }

    #if os(iOS)

    /// EZSE: Adds italic attribute to NSAttributedString and returns it
    public func italic() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }

    /// EZSE: Adds strikethrough attribute to NSAttributedString and returns it
    public func strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)]
        copy.addAttributes(attributes, range: range)

        return copy
    }

    #endif

    /// EZSE: Adds color attribute to NSAttributedString and returns it
    public func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }
}

/// EZSE: Appends one NSAttributedString to another NSAttributedString and returns it
public func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}
    
/// EZSE: Sum of one NSAttributedString with another NSAttributedString
public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    return ns
}


extension NSMutableAttributedString {
    
    
    /// 创建多种显示效果字符串
    ///
    /// - Parameters:
    ///   - full: 全部完整的字符串，以及富文本样式效果
    ///   - specials: 特殊样式的字符串，["特殊显示字符串": [Attributed.Key: 值]]可变参数
    /// - Returns: NSMutableAttributedString
    static public func colorfully(full: [String: [NSAttributedString.Key : Any]], specials:[String: [NSAttributedString.Key : Any]]...) -> NSAttributedString {
        
        var mAttString = NSMutableAttributedString()
        
        if let fKey = full.keys.first, let fAtts = full.values.first {
            mAttString = NSMutableAttributedString(string: fKey, attributes: fAtts)
            
            for item in specials {
                if let key = item.keys.first, let atts = item.values.first {
                    
                    var nsRange = NSRange(location: 0, length: 0)
                    if let range = fKey.range(of: key) {
                        let location = fKey.distance(from: fKey.startIndex, to: range.lowerBound)
                        let length  = fKey.distance(from: range.lowerBound, to: range.upperBound)
                        nsRange = NSRange(location: location, length: length)
                    }
                    
                    mAttString.addAttributes(atts, range: nsRange)
                }
            }
        }
        return mAttString
    }

    
    /// 创建多种显示效果字符串
    ///
    /// - Parameter specials: 特殊样式的字符串，["特殊显示字符串": [Attributed.Key: 值]]可变参数
    /// - Returns: NSMutableAttributedString
    public func colorfully(specials:[String: [NSAttributedString.Key : Any]]...) {
        for item in specials {
            
            if let key = item.keys.first, let atts = item.values.first {
                
                var nsRange = NSRange(location: 0, length: 0)
                if let range = string.range(of: key) {
                    let location = string.distance(from: string.startIndex, to: range.lowerBound)
                    let length  = string.distance(from: range.lowerBound, to: range.upperBound)
                    nsRange = NSRange(location: location, length: length)
                }
                
                self.addAttributes(atts, range: nsRange)
            }
        }
    }
    
    
    
    
    

}


#endif
