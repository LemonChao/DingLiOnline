//
//  ZCLoginInputView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift
import Result

class ZCLoginInputView: UIView {

    
    init(okButtonTitle title: String) {
        super.init(frame: CGRect.zero)
        self.addSubview(phoneNumberField)
        self.addSubview(phoneLine)
        self.addSubview(codeButton)
        self.addSubview(codeField)
        self.addSubview(codeLine)
        self.addSubview(okButton)
        okButton.setTitle(title, for: .normal)
        
        phoneNumberField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(FitWidth(10))
            make.left.right.equalToSuperview()
        }
        phoneLine.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNumberField.snp_bottom).offset(FitWidth(20))
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        codeButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(phoneLine.snp_bottom).offset(FitWidth(25))
            make.size.equalTo(CGSize(width: FitWidth(100), height: FitWidth(24)))
        }
        codeField.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalTo(codeButton.snp_left).offset(FitWidth(-20))
            make.centerY.equalTo(codeButton)
        }
        codeLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(codeButton.snp_bottom).offset(FitWidth(20))
        }
        okButton.snp.makeConstraints { (make) in
            make.top.equalTo(codeLine.snp_bottom).offset(FitWidth(30))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(44))
            make.bottom.equalToSuperview()
        }
        
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
        let viewModel = ZCLoginInputVM.init(phoneNumberField.reactive.continuousTextValues, codeField.reactive.continuousTextValues)
        
//        okButton.reactive.isEnabled <~ viewModel.validSignal
        //通过CocoaAction实现button的点击
        okButton.reactive.pressed = CocoaAction<UIButton>(viewModel.loginAction){
            _ in
            return (self.phoneNumberField.text!, self.codeField.text!)
        }

        //观察登录是否成功
        viewModel.loginAction.values.observeValues({ success in
            if success {
                print("login : \(success)" )
                //VC跳转
            }
        })
        
    }
    
    
    @objc func codeButtonAction(_ button: ZCCountDownButton) {
        
        button.startButtonWith(second: 10, timeChanging: { (countButton, second) -> String in
            return "\(second)s重新获取"
        }, finished: { (countButton) -> String in
            return "获取验证码"
        })
    }
    
    @objc func okButtonAction(_ button: UIButton)  {
        if let vc = self.viewController() {
            if vc.responds(to: #selector(okButtonAction(_:))) {
                vc.perform(#selector(okButtonAction(_:)), with: button)
            }
        }

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var phoneNumberField: UITextField = {
        let field = UITextField.init()
        field.placeholder = "请输入手机号"
        field.textColor = TertiaryColor
        field.font = UIFont.systemFont(ofSize: FontSize(18))
        field.keyboardType = UIKeyboardType.numberPad
        return field
    }()
    let phoneLine = UIView(color: LineColor)
    
    lazy var codeField: UITextField = {
        let field = UITextField.init()
        field.placeholder = "请输入验证码"
        field.textColor = TertiaryColor
        field.font = UIFont.systemFont(ofSize: FontSize(18))
        field.keyboardType = UIKeyboardType.asciiCapableNumberPad
        return field
    }()
    let codeLine = UIView(color: LineColor)
    
    lazy var codeButton: ZCCountDownButton = {
        let button = ZCCountDownButton(type: .custom)
        button.setTitle("获取验证码", for: .normal)
        button.setTitle("获取验证码", for: .disabled)
        button.layer.cornerRadius = FitWidth(4)
        button.layer.borderColor = TertiaryColor.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.setTitleColor(TertiaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.addTarget(self, action: #selector(codeButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = FitWidth(4)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(18))
        button.setBackgroundImage(UIImage.imageColor(PrimaryColor), for: .normal)
//        button.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        return button
    }()
}
