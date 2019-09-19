//
//  ZCGirdPhotosViewCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGirdPhotosViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(urlStr url: String) {
        imgView.kf.setImage(with: URL(string: url))
    }
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()

}
