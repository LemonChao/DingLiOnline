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
    
    
    /// 密码的总位数
    public var passWordNum: UInt = 6
    /// 密码单元框宽
    public var rectangleW: CGFloat = 45
    /// 密码单元框高
    public var rectangleH: CGFloat = 45
    /// 密文密码圆点半径
    public var pointRadius: CGFloat = 6
    /// 密文密码圆点颜色
    public var pointColor: UIColor = UIColor.black
    /// 密码框线宽
    public var boardWidth: CGFloat = 1
    /// 密码框颜色
    public var boardColor: UIColor = UIColor.gray
    /// 密码框圆角 0：直角，大于0 圆角
    public var boardRadius: CGFloat = 0
    /// 密码框的真实输入值
    public var textStore: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
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
        let context = UIGraphicsGetCurrentContext()
        let x = (rect.width - rectangleW * CGFloat(passWordNum)) / 2
        let y = (rect.height - rectangleH) / 2
        
        //画外框
        context?.setLineWidth(boardWidth)
        context?.setStrokeColor(boardColor.cgColor)
        context?.setFillColor(UIColor.white.cgColor)

        if boardRadius <= 0 {
            context?.addRect(CGRect(x: x, y: y, w: rectangleW * CGFloat(passWordNum), h: rectangleH))
        }else { // 当圆角半径为0 时画圆角出来也是一个矩形
            let width = rectangleW*CGFloat(passWordNum)
            
            context?.move(to: CGPoint(x: x+boardRadius, y: y))//左上角开始
            context?.addArc(tangent1End: CGPoint(x: x, y: y), tangent2End: CGPoint(x: x, y: y+boardRadius), radius: boardRadius)//左上圆角
            context?.addArc(tangent1End: CGPoint(x: x, y: y+rectangleH), tangent2End: CGPoint(x: x+boardRadius, y: y+rectangleH), radius: boardRadius)//左下圆角
            context?.addArc(tangent1End: CGPoint(x: x+width, y: y+rectangleH), tangent2End: CGPoint(x: x+width, y: y+boardRadius), radius: boardRadius) //右下圆角
            context?.addArc(tangent1End: CGPoint(x: x+width, y: y), tangent2End: CGPoint(x: x+boardRadius, y: y), radius: boardRadius)//右上圆角
            context?.closePath()
        }
        
        //画竖线
        for i in 1..<passWordNum {
            context?.move(to: CGPoint(x: x+CGFloat(i)*rectangleW, y: y))
            context?.addLine(to: CGPoint(x: x+CGFloat(i)*rectangleW, y: y+rectangleH))
            context?.closePath()
        }
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        
        //画圆点
        if textStore.count >= 1 {
            context?.setFillColor(pointColor.cgColor)
            for i in 1...textStore.count {
                context?.addArc(center: CGPoint(x: x+(CGFloat(i)-0.5)*rectangleW, y: y+rectangleH/2), radius: pointRadius, startAngle: 0, endAngle: .pi*2, clockwise: true)
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
