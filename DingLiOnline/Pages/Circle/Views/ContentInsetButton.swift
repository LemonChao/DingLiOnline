//
//  ContentInsetButton.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/29.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ContentInsetButton: UIButton {
    var inset = UIEdgeInsets.zero
    
    
    init(inset edgInset: UIEdgeInsets) {
        super.init(frame: CGRect.zero)
        inset = edgInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            let size = super.intrinsicContentSize
            if size.width <= 0 || size.height <= 0 {
                return size
            }
            return CGSize(width: size.width+inset.left+inset.right, height: size.height+inset.top+inset.bottom)
        }
    }
    
    
    
    
    
}
