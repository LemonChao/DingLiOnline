//
//  ZCClassifyCollectionSectionHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/2.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCClassifyCollectionSectionHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.orange
        
        titleLabel.frame = CGRect(x: 0, y: 0, w: frame.width, h: frame.height)
        self.addSubview(titleLabel)
        
        titleLabel.text = "文房用具"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize(15))
        label.textColor = PrimaryColor
        return label
    }()
        
}
