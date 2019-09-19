//
//  UIButton+EdgeInsets.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/29.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

enum ImagePosition {
    case Left   //图片在左，标题在右，默认风格
    case Right  //图片在右，标题在左
    case Top    //图片在上，标题在下
    case Bottom //图片在下，标题在上
}


/**
 新问题：此方法在OC版本已经验证过没任何问题，用swift实现b一遍发现，水平方向排列没有任何问题，在竖直方向 inset计算结果是正确的，但是在重排的时候总是出现异常(如果titleEdginset.lef < 5 )
 
 
 
 默认情况下，imageEdgeInsets和titleEdgeInsets都是0。先不考虑height,
 
 if (button.width小于imageView上image的width){图像会被压缩，文字不显示}
 
 if (button.width < imageView.width + label.width){图像正常显示，文字显示不全,这种情况下竖直排列时,要特别注意,已解决}
 https://www.jianshu.com/p/f521505beed9
 if (button.width >＝ imageView.width + label.width){图像和文字都居中显示，imageView在左，label在右，中间没有空隙}
 */
extension UIButton {
    
    
    /**
     *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
     *  注意：1.该方法需在设置图片和标题之后才调用;
     2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
     *
     *  @param postion    图片位置类型
     *  @param spacing 图片和标题之间的间隙
     */

    func imagePosition(_ position: ImagePosition, spacing aSpacing: CGFloat) {
        //反复修改之前要先重置
        self.imageEdgeInsets = UIEdgeInsets.zero
        self.titleEdgeInsets = UIEdgeInsets.zero
        
        let imgW = self.imageView?.image?.size.width ?? 0.0
        let imgH = self.imageView?.image?.size.height ?? 0.0
        let showLabSize = self.titleLabel?.bounds.size
        let showLabW = showLabSize!.width
        let showLabH = showLabSize!.height
        
        let trueSize: CGSize = self.titleLabel?.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))) ?? CGSize(width: 0, height: 0)
        let trueLabW = trueSize.width

        //image中心移动的x距离
        let imageOffsetX = showLabW/2
        //image中心移动的y距离
        let imageOffsetY = showLabH/2 + aSpacing/2
        //label左边缘移动的x距离
        let labelOffsetX1 = imgW/2 - showLabW/2 + trueLabW/2
        //label右边缘移动的x距离
        let labelOffsetX2 = CGFloat(fabsf(Float(imgW/2 + showLabW/2 - trueLabW/2)))

        //label中心移动的y距离
        let labelOffsetY = imgH/2 + aSpacing/2
        
        switch position {
        case .Left:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -aSpacing/2, bottom: 0, right: aSpacing/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: aSpacing/2, bottom: 0, right: -aSpacing/2)
        case .Right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: showLabW + aSpacing/2, bottom: 0, right: -(showLabW + aSpacing/2))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imgW + aSpacing/2), bottom: 0, right: imgW + aSpacing/2)
        case .Top:
            self.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets
                = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX1, bottom: -labelOffsetY, right: labelOffsetX2)
        case .Bottom:
            self.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX1, bottom: labelOffsetY, right: labelOffsetX2)
        }
        
//        print("imgSize:\(self.imageView?.image?.size ?? CGSize.zero) show:\(String(describing: showLabSize)) ture:\(trueSize), imgInsets:\(self.imageEdgeInsets) titleInsets:\(self.self.titleEdgeInsets)")
//        self.setNeedsLayout()

    }
    
    
    /**
     根据图文距button边框的距离 自动调整图文水平间距,
     
     @param postion 图片位置类型
     @param margin 图片、文字离button边框的距离
     */
    func imagePosition(_ position: ImagePosition, margin aMargin: CGFloat) {
        
        if position == .Left || position == .Right {
            let imageWith = self.imageView?.image?.size.width ?? 0.0
            let labelWidth = self.titleLabel?.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))).width ?? 0
            let spacing = self.bounds.size.width - imageWith - labelWidth - aMargin*2
            
            self.imagePosition(position, spacing: spacing)
        }else {
            let imageHeight = self.imageView?.image?.size.height ?? 0.0
            let labelHeight = self.titleLabel?.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))).height ?? 0
            let spacing = self.bounds.size.height - imageHeight - labelHeight - aMargin*2
            
            self.imagePosition(position, spacing: spacing)
        }
    }
    
}



