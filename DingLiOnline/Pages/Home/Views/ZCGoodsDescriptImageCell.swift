//
//  ZCGoodsDescriptImageCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsDescriptImageCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints {$0.edges.equalToSuperview()}

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imgView = UIImageView(contentMode: .scaleAspectFit, image: UIImage(named: "IMG_2862.jpg"))

}
