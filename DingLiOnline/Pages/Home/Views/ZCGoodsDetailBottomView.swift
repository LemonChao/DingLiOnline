//
//  ZCGoodsDetailBottomView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/22.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

enum ZCGoodsAuctionState {
    /// 即将开始
    case ready
    /// 进行中
    case ongoing
    /// 已结束
    case over
}


class ZCGoodsDetailBottomView: ZCBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(kefuButton)
        self.addSubview(tixingButton)
        self.addSubview(buyButton)
        
        kefuButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(30))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: FitWidth(35), height: FitWidth(41)))
        }

        tixingButton.snp.makeConstraints { (make) in
            make.left.equalTo(kefuButton.snp_right).offset(FitWidth(30))
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: FitWidth(60), height: FitWidth(41)))
        }

        buyButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(FitWidth(208))
        }
        self.layoutIfNeeded()
        kefuButton.imagePosition(.Top, margin: 0)
        tixingButton.imagePosition(.Top, spacing: FitWidth(4))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var auctionState:ZCGoodsAuctionState = ZCGoodsAuctionState.ready {
        willSet {
            switch newValue {
            case .ready:
                overLabel.isHidden = true
                buyButton.backgroundColor = AssistBlue
            case .ongoing:
                overLabel.isHidden = true
                buyButton.backgroundColor = GeneralRedColor
            case .over:
                overLabel.isHidden = false
                buyButton.backgroundColor = TertiaryColor
            }
        }
    }
    
    @objc func buyButtonAction(_ button: UIButton) {
        self.viewController?.navigationController?.pushViewController(ZCPayMarginVC(), animated: true)
    }
    
    
    lazy var kefuButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "gooddetail_kefu"), for: .normal)
        button.setTitle("客服", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        button.setTitleColor(ImportantColor, for: .normal)
        return button
    }()
    
    lazy var tixingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "gooddetail_tixing"), for: .normal)
        button.setTitle("开拍提醒", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        button.setTitleColor(ImportantColor, for: .normal)
        return button
    }()

    lazy var buyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = AssistBlue
        button.addCorner(roundedRect: CGRect(x: 0, y: 0, w: FitWidth(208), h: FitWidth(49)), roundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue|UIRectCorner.bottomLeft.rawValue), cornerRadii: CGSize(width: FitWidth(24.5), height: FitWidth(24.5)))
        button.addTarget(self, action: #selector(buyButtonAction(_:)), for: .touchUpInside)
        button.addSubview(buyLabel)
        button.addSubview(marginLabel)
        button.addSubview(overLabel)
        overLabel.isHidden = true
        overLabel.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
        buyLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(FitWidth(10))
        })

        marginLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(FitWidth(9))
        })

        
        return button
    }()
    
    let buyLabel: UILabel = UILabel(text: "立即参拍", textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(15)))
    
    let marginLabel: UILabel = UILabel(text: "（保证金 ￥100）", textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    let overLabel: UILabel = UILabel(text: "该拍品已经结束", textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(15)))
}
