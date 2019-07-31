//
//  ZCCircleCollectionViewCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCircleCollectionViewCell: UICollectionViewCell {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.random()
        self.contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }
}
