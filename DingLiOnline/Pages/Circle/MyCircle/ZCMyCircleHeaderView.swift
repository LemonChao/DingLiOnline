//
//  ZCMyCircleHeaderView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/1.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyCircleHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        avatarImgView.image = UIImage(named: "avatar_default")
        nameLabel.text = "星月菩提"
        levelImgView.image = UIImage(named: "circle_memship1")
        fansNum.text = "23"
        focusNum.text = "3"
        zanNum.text = "4356"
        
        
        
        self.addSubview(avatarImgView)
        self.addSubview(nameLabel)
        self.addSubview(levelImgView)
        self.addSubview(managerButton)
        self.addSubview(fansLabel)
        self.addSubview(fansNum)
        self.addSubview(focusLabel)
        self.addSubview(focusNum)
        self.addSubview(zanLabel)
        self.addSubview(zanNum)
        
        avatarImgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(70), height: FitWidth(70)))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImgView.snp_right).offset(FitWidth(10))
            make.top.equalTo(avatarImgView.snp_top).offset(FitWidth(12))
        }
        levelImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_right).offset(FitWidth(5))
        }
        managerButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
        
        fansLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImgView.snp_right).offset(FitWidth(10))
            make.bottom.equalTo(avatarImgView).inset(FitWidth(FitWidth(10)))
        }
        fansNum.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(fansLabel.snp_right).offset(FitWidth(5))
        }
        
        focusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(fansNum.snp_right).offset(FitWidth(20))
        }
        focusNum.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(focusLabel.snp_right).offset(FitWidth(5))
        }
        
        zanLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(focusNum.snp_right).offset(FitWidth(20))
        }
        zanNum.snp.makeConstraints { (make) in
            make.centerY.equalTo(fansLabel)
            make.left.equalTo(zanLabel.snp_right).offset(FitWidth(5))
        }

        managerButton.imagePosition(.Right, spacing: FitWidth(11))
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.layer.cornerRadius = FitWidth(35)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: FontSize(15))
        view.textColor = ImportantColor
        return view
    }()
    
    lazy var levelImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()

    lazy var managerButton: UIButton = {
        let button = ResizeSpacingButton(position: .Right, spacing: FitWidth(11))
        button.setTitle("个人管理", for: .normal)
        button.setTitleColor(TertiaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15), weight: .medium)
        button.setImage(UIImage(named: "circle_arrowRight_lightGray"), for: .normal)
        return button
    }()
    
    lazy var fansLabel: UILabel = {
        let label = UILabel()
        label.text = "粉丝"
        label.textColor = PrimaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(12))
        return label
    }()
    
    lazy var fansNum: UILabel = {
        let label = UILabel()
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(12))
        return label
    }()
    
    lazy var focusLabel: UILabel = {
        let label = UILabel()
        label.text = "关注"
        label.textColor = PrimaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(12))
        return label
    }()
    
    lazy var focusNum: UILabel = {
        let label = UILabel()
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(12))
        return label
    }()

    lazy var zanLabel: UILabel = {
        let label = UILabel()
        label.text = "获赞"
        label.textColor = PrimaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(12))
        return label
    }()
    
    lazy var zanNum: UILabel = {
        let label = UILabel()
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(12))
        return label
    }()

}
