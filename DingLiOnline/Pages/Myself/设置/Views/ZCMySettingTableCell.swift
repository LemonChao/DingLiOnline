//
//  ZCMySettingTableCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/12.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        titleLab.text = "重置登录密码"
        detailLab.text = "15515015147"
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(detailLab)
        self.contentView.addSubview(arrowImg)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
        }
        arrowImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }

        detailLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(30))
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dictionary:[String: String] = [:] {
        
        didSet {
            titleLab.text = dictionary["text"]
            detailLab.text = dictionary["detailText"]
        }
    }
    
    
    let titleLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
    let detailLab = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)), aligment: .right)
    let arrowImg = UIImageView(image: UIImage(named: "circle_arrowRight_lightGray"))
    
    

}

/// 头像cell
class ZCMySettingAvatarCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        titleLab.text = "重置登录密码"
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(avatarImg)
        self.contentView.addSubview(arrowImg)
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.centerY.equalToSuperview()
        }
        arrowImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
        avatarImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(30))
            make.size.equalTo(CGSize(width: FitWidth(60), height: FitWidth(60)))
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dictionary:[String: String] = [:] {
        
        didSet {
            titleLab.text = dictionary["text"]
            
        }
    }
    
    
    let titleLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
    let arrowImg = UIImageView(image: UIImage(named: "circle_arrowRight_lightGray"))
    let avatarImg:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "portrait_placeholder_normal"))
        imgView.layer.cornerRadius = FitWidth(30)
        imgView.clipsToBounds = true
        return imgView
    }()

}
