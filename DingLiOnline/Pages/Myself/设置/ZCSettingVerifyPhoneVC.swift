//
//  ZCSettingVerifyPhoneVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/4.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSettingVerifyPhoneVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "验证手机号"
        customNavBar.setBottomLine(hidden: true)
    }

    override func configViews() {
        let topLine = UIView(color: ScrollViewBackGroundColor)
        
        let imgView = UIImageView(image: UIImage(named: "myself_safety_tips"))
        imgView.setContentCompressionResistancePriority(.required, for: .horizontal)
        let desLabel = UILabel(text: "为了您的资金安全 请先验证手机号", textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(15)), aligment: .left, lines: 2, backgroundColor: UIColor.clear)
        let phoneLine = UIView(color: ScrollViewBackGroundColor)
        let codeLine = UIView(color: ScrollViewBackGroundColor)
        let codeButton = ZCCountDownButton(title: "获取验证码", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: GeneralRedColor, radius: FitWidth(16), target: self, action: #selector(codeButtonAction(_:)))
        codeButton.setBackgroundColor(HexColor("0xcccccc"), forState: .disabled)
        let nextButton = UIButton(title: "下一步", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(22), target: self, action: #selector(nextButtonAction(_:)))
        
        
        self.view.addSubview(topLine)
        self.view.addSubview(imgView)
        self.view.addSubview(desLabel)
        self.view.addSubview(phoneTF)
        self.view.addSubview(phoneLine)
        self.view.addSubview(codeButton)
        self.view.addSubview(codeTF)
        self.view.addSubview(codeLine)
        self.view.addSubview(errorLabel)
        self.view.addSubview(nextButton)
        
        
        topLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(customNavBar.snp_bottom)
            make.height.equalTo(FitWidth(8))
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(100))
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(60))
        }
        
        desLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(FitWidth(100))
            make.centerY.equalTo(imgView)
            make.left.equalTo(imgView.snp_right).offset(FitWidth(15))
        }
        phoneTF.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(imgView.snp_bottom).offset(FitWidth(62))
        }
        phoneLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneTF.snp_bottom).offset(FitWidth(25))
            make.height.equalTo(1)
        }
        codeButton.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLine.snp_bottom).offset(FitWidth(17))
            make.right.equalToSuperview().inset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(120), height: FitWidth(32)))
        }
        codeTF.snp.makeConstraints { (make) in
            make.centerY.equalTo(codeButton)
            make.left.equalToSuperview().inset(FitWidth(12))
            make.right.equalTo(codeButton.snp_left).offset(FitWidth(-10))
        }
        codeLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(codeButton.snp_bottom).offset(FitWidth(17))
            make.height.equalTo(1)
        }
        errorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(codeLine.snp_bottom).offset(FitWidth(10))
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(codeLine.snp_bottom).offset(FitWidth(45))
            make.height.equalTo(FitWidth(44))
        }
    }
    
    @objc func codeButtonAction(_ button: ZCCountDownButton) {
        
        button.startButtonWith(second: 10, timeChanging: { (countButton, second) -> String in
            return "\(second)s重新获取"
        }) { (countButton) -> String in
            return "获取验证码"
        }
        
    }
    
    @objc func nextButtonAction(_ button: UIButton) {
        self.navigationController?.pushViewController(ZCTradersPasswordVC(), animated: true)
    }
    
    lazy var phoneTF: UITextField = {
        let phone = UITextField()
        phone.textColor = PrimaryColor
        phone.font = UIFont.systemFont(ofSize: FontSize(15))
        phone.keyboardType = .numberPad
        phone.placeholder = "请输入手机号"
        return phone
    }()
    
    lazy var codeTF: UITextField = {
        let code = UITextField()
        code.textColor = PrimaryColor
        code.font = UIFont.systemFont(ofSize: FontSize(15))
        code.keyboardType = .numberPad
        code.placeholder = "请输入验证码"
        return code
    }()

    let errorLabel = UILabel(text: "验证码错误", textColor: GeneralRedColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
}
