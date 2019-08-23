
//
//  ZCGoodsAuctionRecordCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/22.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsAuctionRecordCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.selectionStyle = .none
        nameButton.setTitle("发大水手动阀的说法大", for: .normal)
        stateButton.setTitle("领先", for: .normal)
        timeButton.setTitle("07.10 10:30:56", for: .normal)
        priceButton.setTitle("￥556", for: .normal)

        
        
        self.contentView.addSubview(nameButton)
        self.contentView.addSubview(stateButton)
        self.contentView.addSubview(timeButton)
        self.contentView.addSubview(priceButton)
        
        
        nameButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(stateButton.snp_left).offset(FitWidth(-10))
        }
        
        stateButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(110))
            make.top.bottom.equalToSuperview()
            make.height.equalTo(FitWidth(34))
        }
        
        timeButton.snp.makeConstraints { (make) in
            make.left.equalTo(stateButton.snp_right).offset(50)
            make.centerY.equalToSuperview()
        }
        priceButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var nameButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = false
        button.setTitleColor(GeneralRedColor, for: .selected)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        return button
    }()
    
    lazy var stateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = false
        button.setTitleColor(GeneralRedColor, for: .selected)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        
        return button
    }()
    lazy var timeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = false
        button.setTitleColor(GeneralRedColor, for: .selected)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        
        return button
    }()
    lazy var priceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = false
        button.setTitleColor(GeneralRedColor, for: .selected)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        
        return button
    }()


}
