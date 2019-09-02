//
//  ZCHomeAuctionRecommendView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCHomeAuctionRecommendView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(leftImgView)
        self.addSubview(weekLabel)
        self.addSubview(priceLabel)
        self.addSubview(auctionTitleLab)
        self.addSubview(begainTimeLabel)
        self.addSubview(endTimeLabel)
        self.addSubview(statusLabel)
        
        
        leftImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        weekLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(85))
            make.top.equalToSuperview().inset(FitWidth(35))
            make.size.equalTo(CGSize(width: FitWidth(80), height: FitWidth(32)))
        }
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(weekLabel)
            make.left.equalTo(weekLabel.snp_right).offset(FitWidth(10))
        }
        
        auctionTitleLab.snp.makeConstraints { (make) in
            make.left.equalTo(weekLabel)
            make.top.equalTo(weekLabel.snp_bottom).offset(FitWidth(12))
        }
        
        begainTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weekLabel)
            make.top.equalTo(auctionTitleLab.snp_bottom).offset(FitWidth(12))
        }
        
        endTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weekLabel)
            make.top.equalTo(begainTimeLabel.snp_bottom).offset(FitWidth(8))
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.right.equalTo(FitWidth(-12))
            make.top.equalTo(endTimeLabel.snp_bottom).offset(FitWidth(14))
            make.size.equalTo(CGSize(width: FitWidth(50), height: FitWidth(20)))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: AucModel! {
        willSet {
            leftImgView.kf.setImage(with: URL(string: newValue.smallimage), placeholder: UIImage(named: "home_auction_sepcial"), options: nil, progressBlock: nil, completionHandler: nil)
            weekLabel.text = newValue.weekday
            auctionTitleLab.text = newValue.name
            begainTimeLabel.text = newValue.starttime
            endTimeLabel.text = newValue.endtime
            statusLabel.text = newValue.state.introduce().title
            statusLabel.backgroundColor = newValue.state.introduce().color
        }
    }

    
    let leftImgView: UIImageView = UIImageView(image: UIImage(named: "home_auction_sepcial"))
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = FitWidth(4)
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FitWidth(18))
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.clipsToBounds = true
        return label
    }()
    
    let priceLabel = UILabel()
    lazy var auctionTitleLab: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: FitWidth(24))
        return label
    }()
    
    lazy var begainTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: FontSize(15))
        return label
    }()
    
    lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: FontSize(15))
        return label
    }()
    
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = FitWidth(4)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: FitWidth(12))
        label.backgroundColor = GeneralRedColor
        label.textAlignment = NSTextAlignment.center
        label.clipsToBounds = true
        return label
    }()
}
