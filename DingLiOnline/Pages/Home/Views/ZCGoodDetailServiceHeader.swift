//
//  ZCGoodDetailServiceHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/23.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodDetailServiceHeader: UITableViewHeaderFooterView {


    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.white
        let titleLab = UILabel(text: "服务", textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
        titleLab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        serviceLab.text = "2天退货·支持鉴定·包邮"
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(serviceLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.bottom.equalToSuperview()
            make.height.equalTo(FitWidth(44))
        }
        serviceLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp.right).offset(FitWidth(11))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let serviceLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
    
    
}



class ZCGoodDetailSectionFooter: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let view = UIView(color: LineColor)
        self.contentView.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(FitWidth(8))
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
