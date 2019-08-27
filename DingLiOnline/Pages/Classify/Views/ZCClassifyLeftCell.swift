//
//  ZCClassifyLeftCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/2.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCClassifyLeftCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        lineView.backgroundColor = GeneralRedColor
        self.contentView.addSubview(titleButton)
        self.contentView.addSubview(lineView)
        
        titleButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(FitWidth(5))
        }

        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
            make.width.equalTo(FitWidth(3))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        titleButton.isSelected = selected
        lineView.isHidden = !selected
        self.backgroundColor = selected ? UIColor.white : UIColor.clear
    }
    
    var model: ZCClassifyModel = ZCClassifyModel(jsonData: "") {
        willSet {
            titleButton.setTitle(newValue.name, for: .normal)
        }
    }
    
    
    
    
    
    lazy var titleButton: UIButton = {
        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: FitWidth(12), y: 10, w: FitWidth(60), h: 30)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.setTitleColor(GeneralRedColor, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = UIEdgeInsets.zero
        button.titleEdgeInsets = UIEdgeInsets.zero
        button.imageEdgeInsets = UIEdgeInsets.zero
        return button
    }()
    
    let lineView = UIView()
    
    
}
