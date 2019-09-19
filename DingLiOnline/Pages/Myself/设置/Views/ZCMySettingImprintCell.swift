//
//  ZCMySettingImprintCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/17.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingImprintCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        textLab.text = "版本更新"
        detailButton.setTitle("V1.0.0版本", for: .normal)
        
        
        self.contentView.addSubview(textLab)
        self.contentView.addSubview(detailButton)
        self.contentView.addSubview(arrowImg)
        
        textLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        detailButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(arrowImg.snp_left).offset(FitWidth(-10))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
    let detailButton = UIButton(title: nil, titleColor: HexColor("0xaaaaaa"), font: UIFont.systemFont(ofSize: FontSize(14)), bgColor: nil)
    let arrowImg = UIImageView(image: UIImage(named: "chakan"))
    
    
    
    
    
    
    
    
}
