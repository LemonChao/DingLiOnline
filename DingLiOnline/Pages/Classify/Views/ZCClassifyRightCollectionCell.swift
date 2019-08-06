//
//  ZCClassifyRightCollectionCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/2.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCClassifyRightCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.random()
        nameLabel.text = "水电费"
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(55))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFit
        return view
    }()
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize(12))
        label.textColor = PrimaryColor
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
}
