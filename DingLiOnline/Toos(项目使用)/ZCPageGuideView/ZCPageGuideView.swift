//
//  ZCPageGuideView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/14.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCPageGuideView: UIView {

    
    init(frame: CGRect, imageNames: [String], buttonIsShow: Bool) {
        super.init(frame: frame)
        
        let scrollView = UIScrollView(frame: frame)
        scrollView.contentSize = CGSize(width: frame.width*CGFloat(imageNames.count), height: frame.height)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        
        //skipButton
        let skipButton = UIButton(type: .custom)
        skipButton.frame = CGRect(x:frame.maxX-FitWidth(70), y:StatusBarHeight+FitWidth(10) , w: FitWidth(60), h: FitWidth(25))
        skipButton.layer.cornerRadius = skipButton.h/2
        skipButton.setTitle("5  跳过", for: .normal)
        skipButton.setTitleColor(UIColor.white, for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(14))
        skipButton.backgroundColor = UIColor.lightGray
        skipButton.addTarget(self, action: #selector(dissmissGuideView), for: .touchUpInside)
        self.addSubview(skipButton)
        
        //添加图片
        for (index,name) in imageNames.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: frame.width*CGFloat(index), y: 0, w: frame.width, h: frame.height))
            imageView.image = UIImage(named: name)
            scrollView.addSubview(imageView)
            
            if index == imageNames.count-1 && buttonIsShow { //最后一张 且 button显示
                let startButton = UIButton(frame: CGRect(x: 0, y: frame.height/2, w: frame.width, h: frame.height/2))
                imageView.isUserInteractionEnabled = true
                startButton.addTarget(self, action: #selector(dissmissGuideView), for: .touchUpInside)
                imageView.addSubview(startButton)
            }
            
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func addPageGuideView() {
        let guideView = ZCPageGuideView(frame: UIScreen.main.bounds, imageNames: ["guide_1","guide_2","guide_3"], buttonIsShow: true)
        
        UIApplication.shared.delegate?.window!?.addSubview(guideView)
    }
    
    
    
    @objc func dissmissGuideView()  {
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.backgroundColor = UIColor.clear
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }

    
}

extension ZCPageGuideView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let index = scrollView.contentOffset.y / scrollView.w
        
        
    }
    
    
    
}

