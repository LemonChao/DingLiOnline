//
//  ZCCircleNavigationBarCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCircleNavigationBarCell: UICollectionViewCell {
    
    lazy var button: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.isUserInteractionEnabled = false
        view.setTitleColor(GeneralRedColor, for: .selected)
        view.setTitleColor(PrimaryColor, for: .normal)
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.button.frame = CGRect(x: 0, y: 0, w: frame.width, h: frame.height)
        self.contentView.addSubview(self.button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var isSelected: Bool {
        set {
            super.isSelected = newValue
            self.button.isSelected = newValue
            self.button.titleLabel?.font = newValue ? UIFont.boldSystemFont(ofSize: 18) : UIFont.systemFont(ofSize: 18, weight: .regular)
        }
        
        get {
            return super.isSelected
        }
    }
    
}
