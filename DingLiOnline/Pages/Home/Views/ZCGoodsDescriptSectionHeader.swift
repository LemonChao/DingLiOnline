//
//  ZCGoodsDescriptSectionHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsDescriptSectionHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        titleLabel.text = "拍品属性"
        
        let line = UIView(color: LineColor)
        self.contentView.addSubview(line)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: 0))
            make.height.equalTo(FitWidth(34))
        }
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let titleLabel = UILabel(textColor: ImportantColor, font: UIFont.boldSystemFont(ofSize: FontSize(15)))
    
    
}

