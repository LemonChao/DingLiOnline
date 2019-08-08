//
//  ZCMyselfAssetsCollectionCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/8.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyselfAssetsCollectionCell: UICollectionViewCell {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        self.layoutIfNeeded()
        button.imagePosition(.Top, margin: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var button: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitleColor(PrimaryColor, for: .normal)
        view.setImage(UIImage(named: "zhifuguanli"), for: .normal)
        view.setTitle("保证金管理", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: FitWidth(15))
        view.isUserInteractionEnabled = false
        return view
    }()
    
}
