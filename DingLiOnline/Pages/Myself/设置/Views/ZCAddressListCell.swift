//
//  ZCAddressListCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/3.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCAddressListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        addressLabel.numberOfLines = 2
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        selectButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        nameLabel.text = "是打发斯蒂芬的时候共和国非官方个人头费共和国房间很大方"
        phoneLabel.text = "153789769701"
        addressLabel.text = "的说法是打发第三方是打发第三方打算发的说法第三方爱迪生发的说法爱迪生大沙发 水电费发 为何会 禾嘉股份 450000"
        
        self.contentView.addSubview(selectButton)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(phoneLabel)
        self.contentView.addSubview(addressLabel)
        self.contentView.addSubview(editButton)
        
        selectButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalToSuperview().inset(FitWidth(35))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(selectButton.snp_right).offset(FitWidth(10))
            make.top.equalToSuperview().inset(FitWidth(27))
            make.right.lessThanOrEqualTo(phoneLabel.snp_left).offset(FitWidth(-10))
        }
        phoneLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(FitWidth(12))
            make.right.equalTo(editButton.snp_left).offset(FitWidth(-6))
        }
        
        editButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: FitWidth(30), height: FitWidth(30)))
            make.bottom.equalToSuperview().inset(FitWidth(4))
            make.right.equalToSuperview().inset(FitWidth(6))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
    }

    let selectButton = UIButton(normal: UIImage(named: "check_normal_black"), selected: UIImage(named: "check_select_red"))
    let nameLabel = UILabel(textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(14), weight: .medium))
    let phoneLabel = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(14)))
    let addressLabel = UILabel(textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    let editButton = UIButton(normal: UIImage(named: "circle_comment"), selected: nil)
    
    
    
    
}
