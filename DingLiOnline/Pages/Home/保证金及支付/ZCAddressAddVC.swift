//
//  ZCAddressAddVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/26.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCAddressAddVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ScrollViewBackGroundColor
        self.setupUI()
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "添加收货地址"
    }

    func setupUI() {
        let receiverView = creatCell(placeholder: "收货人", right: FitWidth(12))
        self.receiverTF = receiverView.inputView as? UITextField
        
        let phoneView = creatCell(placeholder: "手机号码", right: FitWidth(40))
        self.phoneTF = phoneView.inputView as? UITextField
        
        let areaView = creatCell(placeholder: "所在地区", right: FitWidth(25))
        self.areaButton = areaView.inputView as? UIButton
        
        let addressView = creatCell(placeholder: "详细地址:如道路、门牌号、小区、楼栋号、单元室等", right: FitWidth(12))
        self.adressTF = addressView.inputView as? UITextField
        
        let codeView = creatCell(placeholder: "邮政编码", right: FitWidth(12))
        self.codeTF = codeView.inputView as? UITextField

        let switchVie = defaultCell()
        self.switchView = switchVie.switchV
        
        
        self.view.addSubview(receiverView.view)
        self.view.addSubview(phoneView.view)
        self.view.addSubview(areaView.view)
        self.view.addSubview(addressView.view)
        self.view.addSubview(codeView.view)
        self.view.addSubview(switchVie.view)
        self.view.addSubview(saveButton)
        
        receiverView.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(NavBarHeight+FitWidth(8))
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        phoneView.view.snp.makeConstraints { (make) in
            make.top.equalTo(receiverView.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        areaView.view.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        addressView.view.snp.makeConstraints { (make) in
            make.top.equalTo(areaView.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        codeView.view.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        switchVie.view.snp.makeConstraints { (make) in
            make.top.equalTo(codeView.view.snp_bottom).offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(49)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(15))
            make.top.equalTo(switchVie.view.snp_bottom).offset(FitWidth(43))
            make.height.equalTo(FitWidth(44))
        }
    }
    
    @objc func areaButtonAction(_ button: UIButton) {
        
    }
    
    @objc func saveButtonAction(_ button: UIButton) {
        
    }

    
    
    func creatCell(placeholder: String, right: CGFloat) -> (view: UIView, inputView: UIView) {
        let view = UIView(color: UIColor.white)
        if placeholder == "所在地区" {
            let button = UIButton(title: placeholder, titleColor: NormalColor, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: nil, target: self, action: #selector(areaButtonAction(_:)))
            button.setTitleColor(PrimaryColor, for: .selected)
            button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            view.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.left.equalToSuperview().inset(FitWidth(12))
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(FitWidth(right))
            }

            let imgView = UIImageView(image: UIImage(named: "arrow_right_333"))
            view.addSubview(imgView)
            imgView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(FitWidth(12))
            }
            
            return (view, button)
        }

        
        
        let inputView = UITextField()
        inputView.textColor = PrimaryColor
        inputView.font = UIFont.systemFont(ofSize: FontSize(15))
        inputView.placeholder = placeholder
        view.addSubview(inputView)
        
        inputView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(right))
        }
        
        if placeholder == "手机号码" {
            inputView.keyboardType = UIKeyboardType.numberPad
            let label = UILabel(text: "+86", textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
            view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(FitWidth(12))
            }
        }
        
        
        if placeholder == "邮政编码" {
            inputView.keyboardType = UIKeyboardType.numberPad
        }
        
        return (view, inputView)
    }
    
    func defaultCell() -> (view: UIView, switchV: UISwitch) {
        let view = UIView(color: UIColor.white)
        let label = UILabel(text: "设为默认地址", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(14)))
        let switchview = UISwitch()
        switchview.onTintColor = GeneralRedColor
        
        view.addSubview(label)
        view.addSubview(switchview)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
        }
        switchview.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
        return (view, switchview)
    }
    
    
    var receiverTF: UITextField!
    var phoneTF: UITextField!
    var areaButton: UIButton!
    var adressTF: UITextField!
    var codeTF: UITextField!
    var switchView: UISwitch!
    
    let saveButton = UIButton(title: "保存", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(22), target: self, action: #selector(saveButtonAction(_:)))
    
}
