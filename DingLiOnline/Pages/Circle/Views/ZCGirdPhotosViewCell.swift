//
//  ZCGirdPhotosViewCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGirdPhotosViewCell: UICollectionViewCell {
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imgView)
        self.contentView.backgroundColor = UIColor.random()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
