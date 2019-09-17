//
//  ZCMySettingNicknameVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/16.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingNicknameVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "修改昵称"
    }
    
    override func configViews() {
        let lineView = UIView(color: GeneralRedColor)
        let noteLabel = UILabel(text: "好昵称可以让大家更容易记住你。", textColor: RGBA(170, 170, 170, 1), font: UIFont.systemFont(ofSize: FontSize(14)))
        
        let saveButton = UIButton(title: "保存", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(24), target: self, action: #selector(saveButtonAction(_:)))
        self.view.addSubview(nickNameTF)
        self.view.addSubview(lineView)
        self.view.addSubview(noteLabel)
        self.view.addSubview(saveButton)
        
        nickNameTF.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(30))
            make.left.right.equalToSuperview().inset(FitWidth(22))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(nickNameTF.snp_bottom).offset(FitWidth(8))
            make.height.equalTo(1)
        }
        noteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nickNameTF)
            make.top.equalTo(lineView.snp_bottom).offset(FitWidth(15))
        }
        saveButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(15))
            make.top.equalTo(noteLabel.snp_bottom).offset(FitWidth(100))
            make.height.equalTo(FitWidth(49))
        }
        
        
    }
    
    @objc func saveButtonAction(_ button: UIButton) {
        
    }
    
    
    
    
    lazy var nickNameTF: UITextField = {
        let field = UITextField()
        field.placeholder = "请输入昵称"
        field.font = UIFont.systemFont(ofSize: FontSize(17))
        field.textColor = ImportantColor
        return field
    }()

}
