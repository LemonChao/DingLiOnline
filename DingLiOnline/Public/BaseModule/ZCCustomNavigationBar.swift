//
//  ZCCustomNavigationBar.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/9.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCustomNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: NavBarHeight))
        self.backgroundColor = UIColor.white
        self.addSubview(backgroundImgView)
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(rightButton)
        self.addSubview(bottomLine)
        
        backgroundImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(StatusBarHeight)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(StatusBarHeight)
            make.left.equalTo(backButton.snp_right).offset(10)
            make.right.equalTo(rightButton.snp_left).offset(-10)
            make.height.equalTo(44)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(StatusBarHeight)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackgroundAlpha(_ alpha: CGFloat)  {
        self.alpha = alpha
        self.backgroundImgView.alpha = alpha
        self.bottomLine.alpha = alpha
    }
    
    func setTintColor(_ color: UIColor) {
        self.titleLabel.textColor = color
        self.backButton.setTitleColor(color, for: .normal)
        self.rightButton.setTitleColor(color, for: .normal)
    }
    
    
    func setBottomLine(hidden isHidden:Bool) {
        self.bottomLine.isHidden = isHidden
    }
    
    func setBackButton(withTitle title: String, color titleColor: UIColor) {
        self.backButton.setTitle(title, for: .normal)
        self.backButton.setTitle(title, for: .highlighted)
        self.backButton.setTitleColor(titleColor, for: .normal)
        self.backButton.setTitleColor(titleColor, for: .highlighted)
    }
    func setBackButton(withImage image: UIImage?)  {
        self.setBackButton(withImage: image, highLightImage: image)
    }
    func setBackButton(withImage image: UIImage?, highLightImage lightImage: UIImage?)  {
        self.backButton.setImage(image, for: .normal)
        self.backButton.setImage(lightImage, for: .highlighted)
    }

    func setRightButton(withTitle title: String, color titleColor: UIColor) {
        self.rightButton.setTitle(title, for: .normal)
        self.rightButton.setTitle(title, for: .highlighted)
        self.rightButton.setTitleColor(titleColor, for: .normal)
        self.rightButton.setTitleColor(titleColor, for: .highlighted)
    }
    func setRightButton(withImage image: UIImage?)  {
        self.setRightButton(withImage: image, highLightImage: image)
    }
    func setRightButton(withImage image: UIImage?, highLightImage lightImage: UIImage?)  {
        self.rightButton.setImage(image, for: .normal)
        self.rightButton.setImage(lightImage, for: .highlighted)
    }

    
    
    @objc func backButtonAction(_ button: UIButton) {
        
//        let currentVC = UIViewController.currentViewController()
//        currentVC.goBack()
        
        if let vc = self.viewController() {
            if vc.responds(to: #selector(backButtonAction(_:))) {
                vc.perform(#selector(backButtonAction(_:)), with: button)
            }else {
                vc.goBack()
            }
        }
        
    }
    
    
    @objc func rightButtonAction(_ button: UIButton)  {
        
        if let vc = self.viewController() {
            if vc.responds(to: #selector(rightButtonAction(_:))) {
                vc.perform(#selector(rightButtonAction(_:)), with: button)
            }
        }
    }
    
    var title: String = "" {
        willSet {
            self.titleLabel.text = newValue
        }
    }
    
    
    
    let backgroundImgView = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize(18), weight: .regular)
        label.textColor = PrimaryColor
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    let bottomLine = UIView(color: LineColor)
    
}

extension UIViewController {
    
    /// 返回事件
    func goBack() {
        if let navi = self.navigationController {
            if navi.viewControllers.count == 1 {
                if self.presentingViewController != nil { //解包出present它的父vc
                    self.dismiss(animated: true, completion: nil)
                }
            }else {
                navi.popViewController(animated: true)
            }
        }else if self.presentingViewController != nil {//解包出present它的父vc
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    class func currentViewController() -> UIViewController {
        let vc = UIApplication.shared.delegate?.window??.rootViewController
        return self.currentViewControllerFrom(vc!)
    }
    
    
    /// 递归查找当前ViewController
    class func currentViewControllerFrom(_ viewController: UIViewController) -> UIViewController {
        if viewController.isKind(of: UINavigationController.self) {
            let navi = viewController as! UINavigationController
            return self.currentViewControllerFrom(navi.viewControllers.last!)
        }
        else if viewController.isKind(of: UITabBarController.self) {
            let tabBar = viewController as! UITabBarController
            return self.currentViewControllerFrom(tabBar.selectedViewController!)
        }
        else if let presentVC = viewController.presentedViewController { //解包viewController present 出的子vc
            return self.currentViewControllerFrom(presentVC)
        }
        else {
            return viewController
        }
        
    }
    
    
}



