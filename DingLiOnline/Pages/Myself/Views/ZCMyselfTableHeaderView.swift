//
//  ZCMyselfTableHeaderView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZCMyselfTableHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addSubview(backgroundImgView)
        self.addSubview(contentView)
        contentView.addSubview(portraitButton)
        contentView.addSubview(nameButton)
        contentView.addSubview(lineView)
        contentView.addSubview(stackView)
        
        backgroundImgView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalToSuperview().inset(FitWidth(104)+StatusBarHeight)
            make.bottom.equalToSuperview().inset(FitWidth(8))
        }
        
        portraitButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(contentView.snp_top)
            make.size.equalTo(CGSize(width: FitWidth(84), height: FitWidth(84)))
        }
        
        nameButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(portraitButton.snp_bottom).offset(FitWidth(10))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(nameButton.snp_bottom).offset(FitWidth(12))
            make.height.equalTo(0.8)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(10))
            make.top.equalTo(lineView.snp_bottom).offset(FitWidth(10))
            make.bottom.equalToSuperview().inset(FitWidth(10))
        }
        
        nameButton.imagePosition(.Right, spacing: FitWidth(10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func wordsButtonAction(_ button: ZCWordsButton) {
        
    }

    var userInfo:[String: JSON] = ["":""] {
        willSet {
            portraitButton.kf.setImage(with: URL(string: newValue["litpic"]!.stringValue), for: .normal)
            nameButton.setTitle(newValue["vx_name"]!.stringValue, for: .normal)
            
            let medalName = newValue["agent_level_id"]!.stringValue.medal(compare: newValue["member_grade_id"]!.stringValue)
            nameButton.setImage(UIImage(named: medalName), for: .normal)
            nameButton.imagePosition(.Right, spacing: FitWidth(10))
            
            for (button) in subButtons{
                switch button.bottomString {
                case "参拍":
                    button.topString = newValue["partake"]!.stringValue
                case "收藏":
                    button.topString = newValue["collect"]!.stringValue
                case "足迹":
                    button.topString = newValue["trace"]!.stringValue
                default:
                    print("")
                }
            }

            
            
        }
    }
    
    
    let backgroundImgView = UIImageView(image: UIImage(named: "myself_headerBG"))
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.addShadow(offset: CGSize(width: 0, height: 2), radius: 3, color: GeneralRedColor, opacity: 0.1, cornerRadius: FitWidth(5))
        return view
    }()

    lazy var portraitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = FitWidth(42)
        button.layer.borderWidth = FitWidth(2)
        button.layer.borderColor = GeneralRedColor.cgColor
        button.clipsToBounds = true
        button.contentMode = UIView.ContentMode.scaleAspectFill
        button.setImage(UIImage(named: "portrait_placeholder_normal"), for: .normal)
        return button
    }()
    
    lazy var nameButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Right, spacing: FitWidth(10))
        button.setTitleColor(ImportantColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FitWidth(15))
        button.isUserInteractionEnabled = false
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = LineColor
        return view
    }()
    
    lazy var myAuction: ZCWordsButton = {
        let button = ZCWordsButton()
        button.topString = "100"
        button.bottomString = "我的参拍"
        return button
    }()
    
    lazy var subButtons: [ZCWordsButton] = {
        let titles: [String] = ["我的参拍","我的收藏","我的足迹"]
        var buttons: [ZCWordsButton] = []
        for title in titles {
            let button = ZCWordsButton()
            button.topString = "0"
            button.bottomString = title
            button.addTarget(self, action: #selector(wordsButtonAction(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: self.subButtons)
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing = FitWidth(40)
        return stack
    }()
}
