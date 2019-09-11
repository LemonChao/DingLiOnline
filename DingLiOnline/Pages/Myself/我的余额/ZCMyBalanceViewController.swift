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
        self.view.addSubview(chargeButton)
        self.view.addSubview(tableView)
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(216))
            
        }
        
        chargeButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(44))
            if IndicatorHomeHeight == 0 {
                make.bottom.equalToSuperview().inset(FitWidth(13))
            }else {
                make.bottom.equalToSuperview().inset(IndicatorHomeHeight)
            }
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp_bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(chargeButton.snp_top)
        }
        
        
    }
    
    
    
    @objc func tixianButtonAction(_ button: UIButton)  {
        self.navigationController?.pushViewController(ZCMyBalanceWithdrawVC(), animated: true)
    }
    
    @objc func chargeButtonAction(_ button: UIButton)  {
        self.navigationController?.pushViewController(ZCMyBalanceChargeVC(), animated: true)
    }

    @objc func moreButtonAction(_ button: UIButton)  {
        self.navigationController?.pushViewController(ZCMyBalanceRecordVC(), animated: true)
    }

    
    lazy var headerView: UIView = {
        let view = UIView()
        let imgView = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "myself_balance_header"))
        imgView.isUserInteractionEnabled = true
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
    let chargeButton = UIButton(title: "充值", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(5), target: self, action: #selector(chargeButtonAction(_:)))
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.estimatedRowHeight = FitWidth(73)
        table.separatorInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        table.separatorColor = HexColor("0xf5f5f5")
        table.delegate = self
        table.dataSource = self
        table.alwaysBounceVertical = false
        table.showsVerticalScrollIndicator = false
        let moreButton = UIButton(title: "查看更多", titleColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: UIColor.white, radius: 0.0, target: self, action: #selector(moreButtonAction(_:)))
        moreButton.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(55))
        table.tableFooterView = moreButton
        
        table.register(ZCMyBalanceTableCell.self, forCellReuseIdentifier: "ZCMyBalanceTableCell_id")
        return table
    }()
    

}


extension ZCMyBalanceViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCMyBalanceTableCell_id") as! ZCMyBalanceTableCell
        return cell
    }
    
    
}
