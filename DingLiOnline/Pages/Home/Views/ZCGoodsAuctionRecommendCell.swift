//
//  ZCGoodsAuctionRecommendCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/23.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsAuctionRecommendCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.random()
        
        imageView.image = UIImage(named: "IMG_2862.jpg")
        priceLabel.text = "￥1456422"
        
        let bottomBG = UIView(color: UIColor.white.withAlphaComponent(0.3))
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(bottomBG)
        bottomBG.addSubview(priceLabel)

        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        bottomBG.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(FitWidth(20))
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomBG).inset(FitWidth(10))
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        return imgView
    }()
    
    let priceLabel = UILabel(textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(14)))
}
