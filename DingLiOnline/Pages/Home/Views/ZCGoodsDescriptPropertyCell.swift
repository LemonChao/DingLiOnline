//
//  ZCGoodsDescriptPropertyCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsDescriptPropertyCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        messageLab.numberOfLines = 0
        titleLab.text = "尺寸"
        messageLab.text = "高：41.8mm 直径：8.7mmx2(手工测量 略有误差) 裸石：直径8.7mmx2(手工测量 略有误差)"
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(messageLab)
        
        messageLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(90))
            make.top.equalToSuperview().inset(FitWidth(10))
            make.bottom.equalToSuperview().inset(FitWidth(4))
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(messageLab)
            make.left.equalToSuperview().inset(FitWidth(12))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    let messageLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    

}
