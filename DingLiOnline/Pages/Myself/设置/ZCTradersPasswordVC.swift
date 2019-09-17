//
//  ZCTradersPasswordVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/4.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCTradersPasswordVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "交易密码"
        customNavBar.setBottomLine(hidden: true)
    }


    override func configViews() {
        let topLine = UIView(color: ScrollViewBackGroundColor)
        
        let imgView = UIImageView(image: UIImage(named: "myself_safety_tips"))
        imgView.setContentCompressionResistancePriority(.required, for: .horizontal)
        let desLabel = UILabel(text: "为了您的资金安全 请先设置交易密码", textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(15)), aligment: .left, lines: 2, backgroundColor: UIColor.clear)
        let psLabel = UILabel(text: "请输入密码", textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let passwordView = ZCPasswordView()
        passwordView.becomeFirstResponder()
        passwordView.delegate = self
        let againLabel = UILabel(text: "请再次输入密码", textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let againPSView = ZCPasswordView()
        againPSView.delegate = self
        submitButton.setBackgroundColor(HexColor("0xcccccc"), forState: .disabled)
        
        
        self.view.addSubview(topLine)
        self.view.addSubview(imgView)
        self.view.addSubview(desLabel)
        self.view.addSubview(psLabel)
        self.view.addSubview(passwordView)
        self.view.addSubview(againLabel)
        self.view.addSubview(againPSView)
        self.view.addSubview(errorButton)
        self.view.addSubview(submitButton)
        
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
        psLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(57))
            make.top.equalTo(imgView.snp_bottom).offset(FitWidth(44))
        }
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(psLabel.snp_bottom).offset(FitWidth(10))
            make.left.equalTo(psLabel)
            make.size.equalTo(CGSize(width: FitWidth(270), height: FitWidth(45)))
        }
        againLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(57))
            make.top.equalTo(passwordView.snp_bottom).offset(FitWidth(20))
        }
        againPSView.snp.makeConstraints { (make) in
            make.top.equalTo(againLabel.snp_bottom).offset(FitWidth(10))
            make.left.equalTo(againLabel)
            make.size.equalTo(CGSize(width: FitWidth(270), height: FitWidth(45)))
        }
        errorButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(57))
            make.top.equalTo(againPSView.snp_bottom).offset(FitWidth(10))
        }
        submitButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(againPSView.snp_bottom).offset(FitWidth(45))
            make.height.equalTo(FitWidth(44))
        }
        
    }
    
    @objc func submitButtonAction(_ button: UIButton) {
        
    }
    
    
    
    lazy var errorButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(6))
        button.setImage(UIImage(named: "margin_note_red"), for: .normal)
        button.setTitle("两次输入的密码不一致", for: .normal)
        button.setTitleColor(GeneralRedColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        button.isUserInteractionEnabled = false
        return button
    }()
    let submitButton = UIButton(title: "提交", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(22), target: self, action: #selector(submitButtonAction(_:)))

}

extension ZCTradersPasswordVC: ZCPasswordViewDelegate {
    func passWordBeginInput(_ passwordView: ZCPasswordView) {
        print("begain+" + passwordView.textStore)
    }
    
    func passwordViewDidChange(_ passwordView: ZCPasswordView) {
        print("change:" + passwordView.textStore)

    }
    func passWordCompleteInput(_ passwordView: ZCPasswordView) {
        print("complete=" + passwordView.textStore)
        passwordView.resignFirstResponder()
        submitButton.isEnabled = true
    }
}
