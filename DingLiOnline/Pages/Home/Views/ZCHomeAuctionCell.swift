//
//  ZCHomeAuctionCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/6.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCHomeAuctionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let attString = NSMutableAttributedString(string: "99元起", attributes: [NSAttributedString.Key.foregroundColor: PrimaryColor,NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize(9))])
        attString.addAttributes([.font: UIFont.systemFont(ofSize: FontSize(5))], range: NSRange(location: attString.length-1, length: 1))
        priceLabel.attributedText = attString
        weekLabel.text = "星期一"
        auctionTitleLab.text = "精选专场拍卖会"
        begainTimeLabel.text = "开始时间:06月26号 21:00 (星期一)"
        endTimeLabel.text = "开始时间:06月26号 21:00 (星期三)"
        statusLabel.text = "热拍中"
        
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
            make.left.equalToSuperview().inset(FitWidth(41))
            make.top.equalToSuperview().inset(FitWidth(5))
            make.size.equalTo(CGSize(width: FitWidth(40), height: FitWidth(16)))
        }
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(weekLabel)
            make.left.equalTo(weekLabel.snp_right).offset(FitWidth(10))
        }
        
        auctionTitleLab.snp.makeConstraints { (make) in
            make.left.equalTo(weekLabel)
            make.top.equalTo(weekLabel.snp_bottom).offset(FitWidth(6))
        }
        
        begainTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weekLabel)
            make.top.equalTo(auctionTitleLab.snp_bottom).offset(FitWidth(6))
        }
        
        endTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weekLabel)
            make.top.equalTo(begainTimeLabel.snp_bottom).offset(FitWidth(4))
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.right.equalTo(FitWidth(-5))
            make.top.equalTo(endTimeLabel.snp_bottom).offset(FitWidth(9))
            make.size.equalTo(CGSize(width: FitWidth(50), height: FitWidth(20)))
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let leftImgView: UIImageView = UIImageView(image: UIImage(named: "home_auction_normal"))
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = FitWidth(4)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: FitWidth(9))
        label.backgroundColor = PrimaryColor
        label.textAlignment = NSTextAlignment.center
        label.clipsToBounds = true
        return label
    }()
    
    let priceLabel = UILabel()
    lazy var auctionTitleLab: UILabel = {
        let label = UILabel()
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FitWidth(12))
        return label
    }()
    
    lazy var begainTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = PrimaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(7))
        return label
    }()
    
    lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = PrimaryColor
        label.font = UIFont.systemFont(ofSize: FontSize(7))
        return label
    }()

    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = FitWidth(4)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: FitWidth(9))
        label.backgroundColor = AssistBlue
        label.textAlignment = NSTextAlignment.center
        label.clipsToBounds = true
        return label
    }()
    
}
