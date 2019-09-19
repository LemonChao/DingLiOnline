
//
//  ZCLoginViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCLoginViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImg)
        self.view.addSubview(titleView)
        self.view.addSubview(loginInput)
        self.view.addSubview(weChatButton)
        self.view.addSubview(policyLabel)
        self.view.addSubview(policyButton)
        
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(FitWidth(100)+StatusBarHeight)
            make.left.right.equalToSuperview()
        }
        
        loginInput.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp_bottom).offset(FitWidth(60))
            make.left.right.equalToSuperview().inset(FitWidth(24))
        }
        
        weChatButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(24))
            make.top.equalTo(loginInput.snp_bottom).offset(FitWidth(12))
            make.height.equalTo(FitWidth(44))
        }
        
        policyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(24))
            make.top.equalTo(weChatButton.snp_bottom).offset(FitWidth(30))
        }
        policyButton.snp.makeConstraints { (make) in
            make.left.equalTo(policyLabel.snp_right)
            make.centerY.equalTo(policyLabel)
        }
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.backgroundColor = UIColor.clear
        customNavBar.setBottomLine(hidden: true)
        customNavBar.setBackButton(withImage: UIImage(named: "close"))
    }
    
    
    @objc func okButtonAction(_ button: UIButton) {
        self.navigationController?.pushViewController(ZCBindPhoneNumberVC(), animated: true)
    }
    
    @objc func weChatButtonAction(_ button: UIButton) {
        
    }
    @objc func policyButtonAction(_ button: UIButton) {
        
    }

    
    lazy var backgroundImg: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "login_background"))
        imgView.frame = UIScreen.main.bounds
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        return imgView
    }()
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "欢迎来到鼎立在线"
        label.textColor = PrimaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(36), weight: .medium)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var loginInput: ZCLoginInputView = {
        let view = ZCLoginInputView(okButtonTitle: "登录/注册")
        return view
    }()
    
    lazy var weChatButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("微信登录", for: .normal)
        button.setBackgroundImage(UIImage.imageColor(RGBA(4, 214, 104, 1)), for: .normal)
        button.layer.cornerRadius = FitWidth(4)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(weChatButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var policyLabel: UILabel = {
        let label = UILabel()
        label.text = "点击“登录/注册”即表示您同意"
        label.textColor = TertiaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(12))
        return label
    }()
    
    lazy var policyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("《鼎力在线服务条款》", for: .normal)
        button.setTitleColor(GeneralRedColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        button.addTarget(self, action: #selector(policyButtonAction(_:)), for: .touchUpInside)
        return button
    }()
}
