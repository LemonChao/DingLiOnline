//
//  ZCGoodsAuctionInfoCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/23.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsAuctionInfoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLab.text = "拍卖类型"
        valueLab.text = "07月12日22:00"
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(valueLab)
        
        self.contentView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.width.equalTo(floor((SCREEN_WIDTH-FitWidth(24))/2))
        }
        
        valueLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(56))
            make.top.bottom.equalToSuperview()
            make.height.equalTo(FitWidth(27))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(valueLab.snp_left).offset(FitWidth(-6))
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.size = self.systemLayoutSizeFitting(attributes.size, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
        
        return attributes
    }
    
    
    let titleLab = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    let valueLab = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    
    
}
