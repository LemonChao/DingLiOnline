//
//  ZCMyselfFeedbackCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/8.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyselfFeedbackCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(cornerBgView)
        cornerBgView.addSubview(feedBackButton)
        cornerBgView.addSubview(problemButton)
        
        cornerBgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: FitWidth(12), bottom: FitWidth(8), right: FitWidth(12)))
        }
        
        feedBackButton.snp.makeConstraints { (make) in
            make.right.equalTo(cornerBgView.centerX).offset(FitWidth(-43))
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(FitWidth(15))
            make.bottom.equalToSuperview().inset(FitWidth(10))
        }
        
        problemButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(feedBackButton)
            make.left.equalTo(cornerBgView.centerX).offset(FitWidth(43))
        }
        
        feedBackButton.imagePosition(.Left, margin: 0)
        problemButton.imagePosition(.Left, margin: 0)

    }
    
    @objc func feedBackButtonAction(_ button: ResizeSpacingButton)  {
        
    }
    
    @objc func problemButtonAction(_ button: ResizeSpacingButton)  {
        
    }

    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    lazy var cornerBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.addShadow(offset: CGSize(width: 0, height: 2), radius: 3, color: GeneralRedColor, opacity: 0.1, cornerRadius: FitWidth(5))
        return view
    }()

    lazy var feedBackButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(10))
        button.setTitle("在线反馈", for: .normal)
        button.setImage(UIImage(named: "kefu"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.setTitleColor(PrimaryColor, for: .normal)
        button.addTarget(self, action: #selector(feedBackButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var problemButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(10))
        button.setTitle("常见问题", for: .normal)
        button.setImage(UIImage(named: "changjianweti"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.setTitleColor(PrimaryColor, for: .normal)
        button.addTarget(self, action: #selector(problemButtonAction(_:)), for: .touchUpInside)
        return button
    }()

}
