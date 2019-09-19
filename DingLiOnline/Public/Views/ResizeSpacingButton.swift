//
//  ResizeSpacingButton.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/29.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit


/// button重排，自适应大小，带有图文间隔
class ResizeSpacingButton: UIButton {

    var position = ImagePosition.Left
    var spacing: CGFloat = 0
    
    
    
    init(position aPosition: ImagePosition, spacing aSpacing:CGFloat) {
        super.init(frame: CGRect.zero)
        position = aPosition
        spacing = aSpacing
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        get {
            let size = super.intrinsicContentSize
            

            if position == ImagePosition.Left || position == ImagePosition.Right {
                return CGSize(width: size.width + spacing, height: size.height)
            }else {
                let imageSize = self.imageView?.image!.size ?? CGSize.zero
                let labelSize = self.titleLabel?.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))) ?? CGSize.zero

                return CGSize(width: max(imageSize.width, labelSize.width), height: imageSize.height+labelSize.height+spacing)
            }
            
        }
    }
    
}
