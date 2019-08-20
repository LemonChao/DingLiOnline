//
//  ConvenienceInitViewExtension.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/15.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

extension UIView {
    /// ConvenienceInitViewExtension - init with color
    public convenience init(color: UIColor) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = color
    }

    public convenience init(cornerRadius: CGFloat) {
        self.init(frame: CGRect.zero)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }

    
}


extension UILabel {
    
    public convenience init(textColor: UIColor, font: UIFont) {
        self.init(frame: CGRect.zero)
        self.textColor = textColor
        self.font = font

    }
    
    public convenience init(textColor: UIColor, font: UIFont, aligment: NSTextAlignment) {
        self.init(frame: CGRect.zero)
        self.textColor = textColor
        self.font = font
        self.textAlignment = aligment
    }
    
    public convenience init(text:String, textColor: UIColor, font: UIFont){
        self.init(frame: CGRect.zero)
        self.text = text
        self.textColor = textColor
        self.font = font

    }
    
    public convenience init(text:String, textColor: UIColor, font: UIFont, backgroundColor:UIColor){
        self.init(frame: CGRect.zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
    }
    
    public convenience init(text:String, textColor: UIColor, font: UIFont, aligment: NSTextAlignment, lines:Int, backgroundColor:UIColor) {
        self.init(frame: CGRect.zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = aligment
        self.numberOfLines = lines
        self.backgroundColor = backgroundColor
    }
    
}


extension UIButton {
    
}


extension UIImageView {
    
}


