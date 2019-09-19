//
//  ZCGoodsAuctionRecordHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/23.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsAuctionRecordHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        let redLine = UIView(color: GeneralRedColor)
        let titleLab = UILabel(text: "拍卖记录", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let grayLine = UIView(color: LineColor)
        let bottomLine = UIView(color: LineColor)
        
        recordLab.text = "100条"
        
        self.contentView.addSubview(redLine)
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(grayLine)
        self.contentView.addSubview(recordLab)
        self.contentView.addSubview(bottomLine)
        
        redLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 2, height: 10))
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(redLine.snp_right).offset(FitWidth(5))
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.height.equalTo(FitWidth(44))
        }
        grayLine.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(titleLab.snp_right).offset(FitWidth(10))
            make.size.equalTo(CGSize(width: 1, height: 14))
        }
        recordLab.snp.makeConstraints { (make) in
            make.left.equalTo(grayLine.snp_right).offset(FitWidth(10))
            make.centerY.equalToSuperview()
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.6)
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let recordLab = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    
    
    
}
