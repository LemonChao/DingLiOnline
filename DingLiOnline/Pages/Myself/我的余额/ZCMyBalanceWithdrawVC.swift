//
//  ZCMyBalanceWithdrawVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyBalanceWithdrawVC: ZCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ScrollViewBackGroundColor
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "提现到银行卡"
        customNavBar.setRightButton(withTitle: "记录", color: GeneralRedColor)
    }
    
    override func configViews() {
        let cardView = setupCardView()
        let moneyView = setupMoneyView()
        let allButton = UIButton(title: "全部提现", titleColor: GeneralRedColor, font: UIFont.systemFont(ofSize: FontSize(14)), bgColor: nil, target: self, action: #selector(allButtonAction(_:)))
        allButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        noteLabel.text = "余额888.96元(单笔最小提fdsfdsafdsgadsfgdsfghfdrhdsafasdf"
        self.view.addSubview(cardView)
        self.view.addSubview(moneyView)
        self.view.addSubview(noteLabel)
        self.view.addSubview(allButton)
        self.view.addSubview(nextButton)
        
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(20))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        moneyView.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp_bottom).offset(FitWidth(20))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        noteLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(moneyView.snp_bottom).offset(FitWidth(16))
        }
        allButton.snp.makeConstraints { (make) in
            make.left.equalTo(noteLabel.snp_right)
            make.right.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalTo(noteLabel)
        }
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(noteLabel.snp_bottom).offset(FitWidth(15))
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(44))
        }
        
        
        bankButton.imagePosition(.Left, margin: 0)
    }
    
    
    
    
    @objc func rightButtonAction(_ button: UIButton) {
        self.navigationController?.pushViewController(ZCMyBanlanceWithdrawRecordVC(), animated: true)
    }
    
    @objc func bankButtonAction(_ button: UIButton) {
        
        ZCSelectWithdrawBankCardView.showWithdrawBankView()
        
    }

    @objc func nextButtonAction(_ button: UIButton) {
        ZCPaymentManagerView.showPayment()
        
        
    }
    
    @objc func allButtonAction(_ button: UIButton) {
    }

    
    func setupCardView() -> UIView{
        
        let view = UIView(color: UIColor.white)
        let label = UILabel(text: "到账银行卡", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(18)))
        let bankActionBtn = UIButton(title: nil, titleColor: nil, font: UIFont.systemFont(ofSize: 12), bgColor: nil, target: self, action: #selector(bankButtonAction(_:)))
        let arrowImg = UIImageView(image: UIImage(named: "circle_arrowRight_lightGray"))
        
        view.addSubview(label)
        view.addSubview(bankActionBtn)
        bankActionBtn.addSubview(arrowImg)
        bankActionBtn.addSubview(bankButton)
        
        bankActionBtn.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(122))
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
            make.right.equalTo(bankActionBtn.snp_left).offset(FitWidth(-18))
        }
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
        }
        
        bankButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(arrowImg.snp_left).offset(FitWidth(-5))
        }

        return view
    }
    
    func setupMoneyView() -> UIView {
        let view = UIView(color: UIColor.white)
        let label = UILabel(text: "提现金额", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(18)))
        
        view.addSubview(label)
        view.addSubview(moneyTF)
        
        moneyTF.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(122))
        }
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
            make.right.equalTo(moneyTF.snp_left).offset(FitWidth(-18))
        }

        return view
    }
    
    
    lazy var bankButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(FitWidth(5)))
        button.setTitle("工商银行-储蓄卡(8967)", for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(14))
        button.setImage(UIImage(named: "ICBC"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var moneyTF: UITextField = {
        let field = UITextField()
        field.placeholder = "请输入提现金额"
        field.font = UIFont.systemFont(ofSize: FontSize(18))
        field.textColor = PrimaryColor
        field.keyboardType = .decimalPad
        return field
    }()
    
    let noteLabel = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(14)))
    let nextButton = UIButton(title: "下一步", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(4), target: self, action: #selector(nextButtonAction(_:)))
    
    
}
