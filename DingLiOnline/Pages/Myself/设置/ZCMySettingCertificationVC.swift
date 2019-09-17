//
//  ZCMySettingCertificationVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/17.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingCertificationVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
        } else {
            automaticallyAdjustsScrollViewInsets = true
        }

    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "实名认证"
    }
    
    override func configViews() {
        nameTF = setupTextField(title: "您的姓名", placeholder: "请输入您的真实姓名")
        let cardTypeTF = setupTextField(title: "证件类型", placeholder: "身份证")
        numberTF = setupTextField(title: "证件号码", placeholder: "请输入证件号码")
        let idView = setupIdPhoto()
        
        self.view.addSubview(nameTF)
        self.view.addSubview(cardTypeTF)
        self.view.addSubview(numberTF)
        self.view.addSubview(idView)
        self.view.addSubview(submitButton)
        
        nameTF.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(49))
        }
        cardTypeTF.snp.makeConstraints { (make) in
            make.top.equalTo(nameTF.snp_bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(49))
        }
        numberTF.snp.makeConstraints { (make) in
            make.top.equalTo(cardTypeTF.snp_bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(49))
        }
        idView.snp.makeConstraints { (make) in
            make.top.equalTo(numberTF.snp_bottom)
            make.left.right.equalToSuperview()
        }
        submitButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(idView.snp_bottom).offset(FitWidth(50))
            make.height.equalTo(FitWidth(49))
        }
        
        
    }
    
    /// 创建输入框
    func setupTextField(title: String, placeholder: String) -> UITextField {
        
        let label = UILabel(text: title, textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        label.frame = CGRect(x: FitWidth(12), y: 0, w: FitWidth(93), h: FitWidth(49))

        let field = UITextField()
        field.backgroundColor = UIColor.white
        field.placeholder = placeholder
        field.font = UIFont.systemFont(ofSize: FontSize(15))
        field.textColor = PrimaryColor
        field.keyboardType = .default

        field.leftView = label
        field.leftViewMode = .always
        
        let lineView = UIView(color: LineColor)
        lineView.frame = CGRect(x: -FitWidth(12), y: FitWidth(49)-0.8, w: SCREEN_WIDTH, h: 0.8)
        field.addSubview(lineView)
        
        if title == "证件类型" {
            field.text = placeholder
            field.isEnabled = false
        }
        
        return field
    }
    
    @objc func avatarButtonAction(_ button: UIButton) {
        selectButton = button
        self.showActionSheet()
    }
    
    @objc func badgeButtonAction(_ button: UIButton) {
        selectButton = button
        self.showActionSheet()
    }
    @objc func submitButtonAction(_ button: UIButton) {
        
    }

    func showActionSheet() {
        
        ZCAlertTools.showActionSheetWith(ViewController: self, title: nil, message: nil, selectClosure: { (title, index) in
            if index == 2 { return }
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = index == 0 ? .camera : .photoLibrary
            self.present(imagePickerController, animated:true)
            
        }, actions: ("打开相机",.default),("从相册选择",.default),("取消",.cancel))
    }
    /// 证件照片
    func setupIdPhoto() -> UIView {
        let view = UIView(color: UIColor.white)
        let titleLab = UILabel(text: "上传证件照片", textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        
        let avatarButton = UIButton(type: .custom)
        avatarButton.setBackgroundImage(UIImage(named: "dottedline_box"), for: .normal)
        avatarButton.setImage(UIImage(named: "idPhoto_add"), for: .normal)
        avatarButton.addTarget(self, action: #selector(avatarButtonAction(_:)), for: .touchUpInside)
        
        let badgeButton = UIButton(type: .custom)
        badgeButton.setBackgroundImage(UIImage(named: "dottedline_box"), for: .normal)
        badgeButton.setImage(UIImage(named: "idPhoto_add"), for: .normal)
        badgeButton.addTarget(self, action: #selector(badgeButtonAction(_:)), for: .touchUpInside)

        let avatarLab = UILabel(text: "头像面", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
        let badgeLab = UILabel(text: "头像面", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
        let noteLab = UILabel()
        noteLab.attributedText = NSMutableAttributedString.colorfully(full: ["注：拍摄时确保证件边框完整、字体清晰、亮度均匀" : [.foregroundColor : GeneralRedColor, .font: UIFont.systemFont(ofSize: FontSize(13))]], specials: ["注：拍摄时确保证件" : [.foregroundColor : PrimaryColor]])
        
        view.addSubview(titleLab)
        view.addSubview(avatarButton)
        view.addSubview(badgeButton)
        view.addSubview(avatarLab)
        view.addSubview(badgeLab)
        view.addSubview(noteLab)
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(FitWidth(30))
            make.left.equalToSuperview().inset(FitWidth(12))
        }
        avatarButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(titleLab.snp_bottom).offset(FitWidth(15))
            make.size.equalTo(CGSize(width: FitWidth(155), height: FitWidth(98)))
        }
        badgeButton.snp.makeConstraints { (make) in
            make.top.equalTo(avatarButton)
            make.right.equalToSuperview().inset(FitWidth(12))
            make.size.equalTo(avatarButton.snp_size)
        }
        avatarLab.snp.makeConstraints { (make) in
            make.top.equalTo(avatarButton.snp_bottom).offset(FitWidth(15))
            make.centerX.equalTo(avatarButton)
        }
        badgeLab.snp.makeConstraints { (make) in
            make.top.equalTo(badgeButton.snp_bottom).offset(FitWidth(15))
            make.centerX.equalTo(badgeButton)
        }
        noteLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(avatarLab.snp_bottom).offset(FitWidth(20))
            make.bottom.equalToSuperview().inset(FitWidth(20))
        }
        
        return view
    }
    
    
    
    
    var nameTF: UITextField!
    var numberTF: UITextField!
    let submitButton = UIButton(title: "提交", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(24.5), target: self, action: #selector(submitButtonAction(_:)))
    var selectButton: UIButton! // 点击 上传证件哪一面
    
    
    
    deinit {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

    }
}

extension ZCMySettingCertificationVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectButton.setImage(image, for: .normal)
        selectButton.setBackgroundImage(nil, for: .normal)

    }
    
    
}


