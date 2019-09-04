//
//  ZCPasswordView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/4.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

@objc protocol ZCPasswordViewDelegate: NSObjectProtocol {
    
    /// 输入改变
    @objc optional func passwordViewDidChange(_ passwordView: ZCPasswordView)
 
    /// 输入完成
    @objc optional func passWordCompleteInput(_ passwordView: ZCPasswordView)

    /// 开始输入
    @objc optional func passWordBeginInput(_ passwordView: ZCPasswordView)
}


class ZCPasswordView: ZCBaseView, UIKeyInput {

    public var delegate: ZCPasswordViewDelegate?
    public var passWordNum: UInt = 6
    public var squareWidth: CGFloat = 45
    public var pointRadius: CGFloat = 6
    public var boardWidth: CGFloat = 1
    public var pointColor: UIColor = UIColor.black
    public var boardColor: UIColor = UIColor.gray
    public var textStore: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func becomeFirstResponder() -> Bool {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.passWordBeginInput(_:))))! {
            self.delegate?.passWordBeginInput?(self)
        }
        return super.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isFirstResponder {
            self.becomeFirstResponder()
        }
    }
    
    var keyboardType: UIKeyboardType {
        set {

        }
        get {
            return .numberPad
        }
        
    }
    
    
    override func draw(_ rect: CGRect) {
        let x = (rect.width - squareWidth * CGFloat(passWordNum)) / 2
        let y = (rect.height - squareWidth) / 2
        
        let context = UIGraphicsGetCurrentContext()
        //画外框
        context?.addRect(CGRect(x: x, y: y, w: squareWidth * CGFloat(passWordNum), h: squareWidth))
        context?.setLineWidth(boardWidth)
        context?.setStrokeColor(boardColor.cgColor)
        context?.setFillColor(UIColor.white.cgColor)
        //画竖线
        for i in 1...passWordNum {
            context?.move(to: CGPoint(x: x+CGFloat(i)*squareWidth, y: y))
            context?.addLine(to: CGPoint(x: x+CGFloat(i)*squareWidth, y: y+squareWidth))
            context?.closePath()
        }
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        //画圆点
        if textStore.count >= 1 {
            context?.setFillColor(pointColor.cgColor)
            for i in 1...textStore.count {
                context?.addArc(center: CGPoint(x: x+(CGFloat(i)-0.5)*squareWidth, y: y+squareWidth/2), radius: pointRadius, startAngle: 0, endAngle: .pi*2, clockwise: true)
                context?.drawPath(using: CGPathDrawingMode.fill)
            }
        }
    }
    
    //MARK:-  UIKeyInput
    /// 用于显示的文本对象是否有任何文本
    var hasText: Bool {
        return !self.textStore.isEmpty
    }
    
    /// 插入文本
    func insertText(_ text: String) {
        if textStore.count < passWordNum {
            textStore.append(text)
            
            if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.passwordViewDidChange(_:))))! {
                self.delegate?.passwordViewDidChange?(self)
            }
            
            if textStore.count == passWordNum {
                if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.passWordCompleteInput(_:))))! {
                    self.delegate?.passWordCompleteInput?(self)
                }
            }

            self.setNeedsDisplay()
        }
    }
    
    /// 删除文本
    func deleteBackward() {
        if textStore.count > 0 {
            textStore.remove(at: textStore.index(before: textStore.endIndex))
            if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.passwordViewDidChange(_:))))! {
                self.delegate?.passwordViewDidChange?(self)
            }
            self.setNeedsDisplay()
        }
    }

    
}
