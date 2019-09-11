//
//  ZCSelectWithdrawBankCardView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/11.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

/// 选择到账银行卡
class ZCSelectWithdrawBankCardView: ZCBaseView {

    class func showWithdrawBankView() {
        let bankView = ZCSelectWithdrawBankCardView(frame: UIScreen.main.bounds)
        
        UIApplication.shared.keyWindow?.addSubview(bankView)
        
        bankView.showAnimated()
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGBA(0, 0, 0, 0)
        self.addSubview(contentView)
        contentView.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAnimated() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = RGBA(0, 0, 0, 0.3)
            self.contentView.frame = CGRect(x: 0, y: SCREEN_HEIGHT-self.contentH, width: SCREEN_WIDTH, height: self.contentH)
        }

    }
    
    
    
    @objc func closeButtonAction(_ button: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = RGBA(0, 0, 0, 0)
            self.contentView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: self.contentH)
        }) { (finish) in
            self.removeFromSuperview()
        }

    }
    
    let contentH = FitWidth(300)+IndicatorHomeHeight
    
    
    lazy var contentView: UIView = {
        let view = UIView(color: UIColor.white)
        view.frame = CGRect(x: 0, y: SCREEN_HEIGHT, w: SCREEN_WIDTH, h: contentH)
        view.addCorner(roundedRect: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: contentH), roundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue|UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: FitWidth(4), height: FitWidth(4)))
        let titleLab = UILabel(text: "选择到账银行卡", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(14)))
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "selectBank_close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)
        
        view.addSubview(titleLab)
        view.addSubview(closeButton)
        
        titleLab.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(FitWidth(23))
        })
        closeButton.snp.makeConstraints({ (make) in
            make.centerY.equalTo(titleLab)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: FitWidth(44), height: FitWidth(44)))
        })
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: FitWidth(60), w: SCREEN_WIDTH, h: FitWidth(240)), style: .plain)
        table.rowHeight = FitWidth(60)
        table.dataSource = self
        table.delegate = self
        table.alwaysBounceVertical = false
        table.separatorColor = HexColor("0xf5f5f5")
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.showsVerticalScrollIndicator = false
        table.register(ZCWithdrawBankCell.self, forCellReuseIdentifier: "ZCWithdrawBankCell_id")
        return table
    }()
    
    
    
}

extension ZCSelectWithdrawBankCardView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCWithdrawBankCell_id") as! ZCWithdrawBankCell
        
        return cell
    }
    
    
}



class ZCWithdrawBankCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bankName.text = "工商银行－储蓄卡(8967)"
        
        self.contentView.addSubview(logoImg)
        self.contentView.addSubview(bankName)
        self.contentView.addSubview(selectButton)
        
        logoImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(1)
            make.left.equalToSuperview().inset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(24), height: FitWidth(24)))
        }
        bankName.snp.makeConstraints { (make) in
            make.centerY.equalTo(logoImg)
            make.left.equalTo(logoImg.snp_right).offset(FitWidth(10))
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(logoImg)
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectButton.isSelected = selected
    }
    
    
    
    let logoImg = UIImageView(contentMode: .scaleAspectFit, image: UIImage(named: "ICBC"))
    let bankName = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(18)))
    
    let selectButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "withdrawBank_select"), for: .selected)
        button.setImage(UIImage(named: "withdrawBank_normal"), for: .normal)
        return button
    }()
    
    
    
}


