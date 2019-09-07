//
//  ZCMyBalanceViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyBalanceViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.setBottomLine(hidden: true)
        customNavBar.title = "余额"
    }
    
    override func configViews() {
        self.view.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(216))
            
        }
        
    }
    
    
    
    @objc func tixianButtonAction(_ button: UIButton)  {
        
    }
    
    
    lazy var headerView: UIView = {
        let view = UIView()
        let imgView = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "myself_balance_header"))
        let yuerLabel = UILabel(text: "余额账户(元)", textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(14)))
        let tixianButton = UIButton(title: "提现到银行卡", titleColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: FontSize(15)), bgColor: UIColor.clear, target: self, action: #selector(tixianButtonAction(_:)))
        dateLabel.text = "2019-07-25"
        moneyLabel.text = "88888888.77"
        
        
        view.addSubview(imgView)
        imgView.addSubview(yuerLabel)
        imgView.addSubview(moneyLabel)
        imgView.addSubview(tixianButton)
        
        view.addSubview(self.dateLabel)
        imgView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(180))
        })
        moneyLabel.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalToSuperview().offset(FitWidth(48))
        })
        yuerLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(moneyLabel.snp_bottom).offset(FitWidth(14))
            make.centerX.equalToSuperview()
        })

        tixianButton.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().inset(FitWidth(7))
            make.centerX.equalToSuperview()

        })
        
        
        dateLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: FitWidth(120), height: FitWidth(24)))
        })
        
        return view
    }()

    
    let dateLabel:UILabel = {
        let label = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(12)), aligment: .center)
        label.backgroundColor = RGBA(245, 245, 245, 1)
        label.layer.cornerRadius = FitWidth(12)
        label.clipsToBounds = true
        return label
    }()
    let moneyLabel = UILabel(textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(40), weight: .medium), aligment: .center)
    
    

}
