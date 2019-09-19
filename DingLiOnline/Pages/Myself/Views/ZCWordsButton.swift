//
//  ZCWordsButton.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/7.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCWordsButton: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(topLabel)
        self.addSubview(bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        topLabel.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        bottomLabel.snp.updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    
    override var intrinsicContentSize: CGSize {
        get {
            let topSize = topLabel.intrinsicContentSize
            let bottomSize = bottomLabel.intrinsicContentSize
            return CGSize(width: max(topSize.width, bottomSize.width), height: topSize.height+bottomSize.height)
            
        }
    }
    
    
    var topString: String = "" {
        willSet {
            if newValue != self.topString{
                self.topString = newValue
                self.topLabel.text = newValue
                self.setNeedsUpdateConstraints()
            }
        }
    }
    var bottomString: String = "" {
        willSet {
            if newValue != self.bottomString {
                self.bottomString = newValue
                self.bottomLabel.text = newValue
                self.setNeedsUpdateConstraints()
            }
        }
    }
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = ImportantColor
        label.font = UIFont.systemFont(ofSize: FontSize(15))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.textColor = ImportantColor
        label.font = UIFont.systemFont(ofSize: FontSize(15))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
}
