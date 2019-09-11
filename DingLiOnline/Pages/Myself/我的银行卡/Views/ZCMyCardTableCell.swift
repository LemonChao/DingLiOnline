//
//  ZCMyCardTableCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/11.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyCardTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        bankLabel.text = "交通银行"
        typeLabel.text = "储蓄卡"
        numberLabel.text = "****　　****　　****　　8567"
        
        self.contentView.addSubview(gradientView)
        gradientView.addSubview(bankLabel)
        gradientView.addSubview(typeLabel)
        gradientView.addSubview(numberLabel)
        
        bankLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(65))
            make.top.equalToSuperview().inset(FitWidth(30))
        }
        typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bankLabel)
            make.top.equalTo(bankLabel.snp_bottom).offset(FitWidth(4))
        }
        numberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bankLabel)
            make.top.equalTo(typeLabel.snp_bottom).offset(FitWidth(22))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let gradientView: UIView = {
        let view = UIView(frame: CGRect(x: FitWidth(20), y: FitWidth(12), w: SCREEN_WIDTH-FitWidth(40), h: FitWidth(132)))
        
        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor(red: 0.31, green: 0.51, blue: 0.85, alpha: 1).cgColor, UIColor(red: 0.07, green: 0.36, blue: 0.85, alpha: 1).cgColor]
        gradient.colors = [UIColor.random().cgColor, UIColor.random().cgColor]

        gradient.cornerRadius = FitWidth(4)
        gradient.masksToBounds = true
//        gradient.colors = [UIColor.black.cgColor, UIColor.red.cgColor]
        
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds

        view.layer.addSublayer(gradient)
        
        return view
    }()
    
    let bankLabel = UILabel(textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(17)))
    let typeLabel = UILabel(textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(14)))
    let numberLabel = UILabel(textColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: FontSize(15)))
    
    
    

}
