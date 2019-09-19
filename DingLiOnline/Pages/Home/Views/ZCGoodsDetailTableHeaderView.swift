//
//  ZCGoodsDetailTableHeaderView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/22.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsDetailTableHeaderView: ZCBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let lineView = UIView(color: LineColor)
        
        self.addSubview(cycleScrollView)
        cycleScrollView.addSubview(pagesLabel)
        self.addSubview(stateView)
        self.addSubview(goodsNameLabel)
        self.addSubview(currentPriceLab)
        self.addSubview(weiguanLab)
        self.addSubview(tixingLab)
        self.addSubview(lineView)
        
        goodsNameLabel.text = "缅甸老坑冰种翡翠A货渡母观音挂件18g"
        currentPriceLab.attributedText = NSMutableAttributedString.colorfully(full: ["当前价￥8888(元）":[.foregroundColor: PrimaryColor, .font: UIFont.systemFont(ofSize: FontSize(12))]], specials:["￥":[.foregroundColor: AssistBlue, .font: UIFont.boldSystemFont(ofSize: FontSize(9))]],["8888": [.foregroundColor: AssistBlue, .font: UIFont.boldSystemFont(ofSize: FontSize(14))]])
        weiguanLab.attributedText = self.attributeString(fullString: "围观 120 次", specialString: "120")
        tixingLab.attributedText = self.attributeString(fullString: "设置提醒 10 人", specialString: "10")
        
        pagesLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(FitWidth(15))
            make.right.equalToSuperview().inset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(46), height: FitWidth(24)))
        }
        stateView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(cycleScrollView.snp_bottom)
            make.height.equalTo(FitWidth(30))
        }
        goodsNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(stateView.snp_bottom).offset(FitWidth(15))
        }
        currentPriceLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(goodsNameLabel.snp_bottom).offset(FitWidth(7))
        }
        weiguanLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(currentPriceLab.snp_bottom).offset(FitWidth(15))
        }
        tixingLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(weiguanLab)
            make.left.equalTo(weiguanLab.snp_right).offset(FitWidth(65))
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(FitWidth(8))
        }
        
        timingButton.imagePosition(.Left, margin: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attributeString(fullString: String, specialString: String) -> NSAttributedString {
        let mAttString = NSMutableAttributedString(string: fullString, attributes: [NSAttributedString.Key.foregroundColor: TertiaryColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize(12))])
        
        mAttString.colorfully(specials: [specialString: [NSAttributedString.Key.foregroundColor: PrimaryColor]])
        return mAttString
    }
    
    
    
    lazy var cycleScrollView: SDCycleScrollView = {
        let cycle = SDCycleScrollView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(350)), delegate: self, placeholderImage: nil)!
        cycle.imageURLStringsGroup = ["http://pvhxdhli0.bkt.clouddn.com/stephencurry_niceshot.jpg","http://pvhxdhli0.bkt.clouddn.com/FvahC9fwx9_AH8NquDNjZ3P91sff","http://pvhxdhli0.bkt.clouddn.com/FuC4DiOddVx04DHX5a2DUM87zDwt","http://pvhxdhli0.bkt.clouddn.com/chicken_bbq.jpg","http://pvhxdhli0.bkt.clouddn.com/FhTDab6qCq6VnbntJiKt8kP6rQIj"]
        cycle.autoScrollTimeInterval = 4
        cycle.bannerImageViewContentMode = UIView.ContentMode.scaleAspectFill
        cycle.showPageControl = false
        return cycle
    }()
    
    lazy var pagesLabel: UILabel = {
        let label = UILabel(textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(15)), aligment: .center)
        label.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        label.setCornerRadius(radius: FitWidth(12))
        return label
    }()
    
    var auctionState:ZCGoodsAuctionState = ZCGoodsAuctionState.ready {
        willSet {
            switch newValue {
            case .ready:
                timingButton.setImage(UIImage(named: "goods_auction_timing"), for: .normal)
                timingButton.setTitle("即将开拍 7月12日12:00结束", for: .normal)
                timingButton.imagePosition(.Left, margin: 0)
                stateView.backgroundColor = AssistBlue
            case .ongoing:
                timingButton.setImage(UIImage(named: "goods_auction_timing"), for: .normal)
                timingButton.setTitle("即将开拍 7月12日12:00结束", for: .normal)
                timingButton.imagePosition(.Left, margin: 0)
                stateView.backgroundColor = GeneralRedColor
            case .over:
                timingButton.setImage(UIImage(named: "goods_auction_over"), for: .normal)
                timingButton.setTitle("已结束 拍品成交", for: .normal)
                timingButton.imagePosition(.Left, margin: 0)
                stateView.backgroundColor = TertiaryColor
            }
        }
    }

    lazy var timingButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(6))
        button.setImage(UIImage(named: "goods_auction_timing"), for: .normal)
        button.setTitle("即将开拍", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(FitWidth(15)))
        return button
    }()
    
    lazy var stateView: UIView = {
        let view = UIView(color: AssistBlue)
        view.addSubview(timingButton)
        timingButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(FitWidth(40))
            make.centerY.equalToSuperview()
        })
        return view
    }()
    
    let goodsNameLabel = UILabel(textColor: PrimaryColor, font: UIFont.boldSystemFont(ofSize: FontSize(15)))
    let currentPriceLab = UILabel()
    let weiguanLab = UILabel()
    let tixingLab = UILabel()
    
    
    
    
}


extension ZCGoodsDetailTableHeaderView: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        pagesLabel.text = "\(index+1)/\(cycleScrollView.imageURLStringsGroup.count)"
    }
    
    
}


