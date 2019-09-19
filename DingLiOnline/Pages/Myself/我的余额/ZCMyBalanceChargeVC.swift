//
//  ZCMyBalanceChargeVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyBalanceChargeVC: ZCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ScrollViewBackGroundColor

    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "充值"
    }

    override func configViews() {
        let moneyView = setupMoneyView()

        self.view.addSubview(moneyView)
        self.view.addSubview(nextButton)
        
        moneyView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(20))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(moneyView.snp_bottom).offset(FitWidth(64))
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(44))
        }

        
    }
    
    @objc func nextButtonAction(_ button: UIButton) {
        ZCPaymentManagerView.showPayment()
        
    }

    
    func setupMoneyView() -> UIView {
        let view = UIView(color: UIColor.white)
        let label = UILabel(text: "充值金额", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(18)))
        
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
    
    lazy var moneyTF: UITextField = {
        let field = UITextField()
        field.placeholder = "请输入充值金额"
        field.font = UIFont.systemFont(ofSize: FontSize(18))
        field.textColor = PrimaryColor
        field.keyboardType = .decimalPad
        return field
    }()
    let nextButton = UIButton(title: "下一步", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(4), target: self, action: #selector(nextButtonAction(_:)))

}
