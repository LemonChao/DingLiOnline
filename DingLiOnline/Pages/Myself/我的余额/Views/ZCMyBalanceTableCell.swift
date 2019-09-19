//
//  ZCMyBalanceTableCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyBalanceTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLab.text = "粉丝收益"
        timeLab.text = "2019-07-25 11:28"
        incomeLab.text = "+88"
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(timeLab)
        self.contentView.addSubview(incomeLab)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalToSuperview().inset(FitWidth(20))
        }
        
        incomeLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLab)
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp_bottom).offset(FitWidth(10))
            make.left.equalToSuperview().inset(FitWidth(12))
            make.bottom.equalToSuperview().inset(FitWidth(20))
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let titleLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(14)))
    let timeLab = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    let incomeLab = UILabel(textColor: GeneralRedColor, font: UIFont.boldSystemFont(ofSize: FontSize(14)))
    
    
    
    
    
}
