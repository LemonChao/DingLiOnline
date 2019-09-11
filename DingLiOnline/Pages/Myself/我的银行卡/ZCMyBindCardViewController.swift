//
//  ZCMyBindCardViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/11.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

/// 绑定银行卡
class ZCMyBindCardViewController: ZCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ScrollViewBackGroundColor
        
        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "绑定银行卡"
        
    }
    
    override func configViews() {
        self.view.addSubview(headButton)
        
        let cardNumber = setupinputCell(title: "银行卡号", placeholder: "请输入银行卡号")
        let bankName = setupinputCell(title: "银行名称", placeholder: "请选择银行名称")
        let name = setupinputCell(title: "姓名", placeholder: "小可爱")
        let phone = setupinputCell(title: "手机号码", placeholder: "请输入手机号码")
        let code = setupinputCell(title: "验证码", placeholder: "请输入验证码")

        bankNumberTF = cardNumber.textField
        phoneTF = phone.textField
        codeTF = code.textField
        
        self.view.addSubview(cardNumber.view)
        self.view.addSubview(bankName.view)
        self.view.addSubview(name.view)
        self.view.addSubview(phone.view)
        self.view.addSubview(code.view)

        headButton.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(18))
            make.left.equalToSuperview().inset(FitWidth(12))
        }
        cardNumber.view.snp.makeConstraints { (make) in
            make.top.equalTo(headButton.snp_bottom).offset(FitWidth(18))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        bankName.view.snp.makeConstraints { (make) in
            make.top.equalTo(cardNumber.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        name.view.snp.makeConstraints { (make) in
            make.top.equalTo(bankName.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        phone.view.snp.makeConstraints { (make) in
            make.top.equalTo(name.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        code.view.snp.makeConstraints { (make) in
            make.top.equalTo(phone.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }

        
        headButton.imagePosition(.Right, margin: 0)
        bankButton.imagePosition(.Left, margin: 0)
    }
    
    @objc func headButtonAction(_ button: UIButton) {
        
    }
    
    @objc func codeButtonAction(_ button: ZCCountDownButton) {
        
        button.startButtonWith(second: 10, timeChanging: { (countButton, second) -> String in
            return "\(second)s重新获取"
        }, finished: { (countButton) -> String in
            return "获取验证码"
        })

    }
    
    @objc func bankButtonAction(_ button: UIButton) {
        let selectVC = ZCMySelectBankVC()
        
        selectVC.backCompleteEnclosure = {(name: String) in
            button.setImage(UIImage(named: "ICBC"), for: .selected)
            button.setTitle(name, for: .selected)
            button.backgroundColor = UIColor.white
            button.isSelected = true
            button.imagePosition(.Left, margin: 0)
        }
        
        self.navigationController?.pushViewController(selectVC, animated: true)
    }
    
    func setupinputCell(title: String, placeholder: String) -> (view:UIView, textField:UITextField) {
        let view = UIView(color: UIColor.white)
        let label = UILabel(text: title, textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        
        let field = UITextField()
        field.placeholder = placeholder
        field.font = UIFont.systemFont(ofSize: FontSize(15))
        field.textColor = PrimaryColor
        field.keyboardType = .numberPad
    
        view.addSubview(label)
        view.addSubview(field)
        
        if title == "姓名" {
            field.text = "小可爱"
            field.isEnabled = false
        }
        if title == "验证码" {
            field.rightView = codeButton
            codeButton.frame = CGRect(x: 0, y: 0, w: FitWidth(120), h: FitWidth(32))
            field.rightViewMode = .always
        }
        if title == "银行名称" {
            let arrowImg = UIImageView(image: UIImage(named: "circle_arrowRight_lightGray"))
            field.rightView = arrowImg
            field.rightViewMode = .always
            field.isEnabled = false
            view.addSubview(bankButton)
            
            bankButton.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().inset(FitWidth(105))
            }
        }
        
        
        field.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(FitWidth(12))
            make.left.equalToSuperview().inset(FitWidth(105))
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
            make.right.equalTo(field.snp_left).offset(FitWidth(-18))
        }
        
        return (view, field)
    }
    
    let headButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Right, spacing: FitWidth(6))
        button.addTarget(self, action: #selector(headButtonAction(_:)), for: .touchUpInside)
        let attStr = NSMutableAttributedString.colorfully(full: ["请添加小可爱的银行卡" : [NSAttributedString.Key.foregroundColor : TertiaryColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize(15))]], specials: ["小可爱" : [NSAttributedString.Key.foregroundColor : PrimaryColor]])
        button.setAttributedTitle(attStr, for: .normal)
        button.setImage(UIImage(named: "margin_note_red"), for: .normal)
        button.addTarget(self, action: #selector(headButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var bankButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(FitWidth(10)))
        button.setTitle("工商银行-储蓄卡(8967)", for: .selected)
        button.setTitleColor(PrimaryColor, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.setImage(UIImage(named: "ICBC"), for: .selected)
        let normalImg = UIImage(color: UIColor.clear, size: CGSize(width: FitWidth(230), height: FitWidth(49)))
        button.setImage(normalImg, for: .normal)
        button.addTarget(self, action: #selector(bankButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    
    lazy var codeButton: ZCCountDownButton = {
        let button = ZCCountDownButton(type: .custom)
        button.backgroundColor = UIColor.white
        button.setTitle("获取验证码", for: .normal)
        button.setTitle("获取验证码", for: .disabled)
        button.layer.cornerRadius = FitWidth(4)
        button.layer.borderColor = RGBA(170, 170, 170, 1).cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.setTitleColor(TertiaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.addTarget(self, action: #selector(codeButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    var bankNumberTF: UITextField!
    var phoneTF: UITextField!
    var codeTF: UITextField!
    
}
