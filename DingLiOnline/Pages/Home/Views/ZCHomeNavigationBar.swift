//
//  ZCHomeNavigationBar.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/6.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCHomeNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(searchBGView)
        searchBGView.addSubview(searchButton)
        self.addSubview(signInButton)
        self.addSubview(newsButton)
        
        newsButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(FitWidth(16))
            make.centerY.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(newsButton.snp_left).offset(FitWidth(-14))
        }
        
        searchBGView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
            make.right.equalTo(signInButton.snp_left).offset(FitWidth(-14))
            make.height.equalTo(FitWidth(32))
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(16))
            make.centerY.equalToSuperview()
        }
        
        
        searchButton.imagePosition(.Left, spacing: FitWidth(5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func searchButtonAction(_ button: UIButton)  {
        
    }
    
    @objc func signInButtonAction(_ button: UIButton)  {
        
    }
    
    @objc func newsButtonAction(_ button: UIButton)  {
        
    }
    
    lazy var searchBGView: UIView = {
        let view = UIButton(type: .custom)
        view.layer.cornerRadius = FitWidth(16)
        view.layer.borderColor = TertiaryColor.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(searchButtonAction(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var searchButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(5))
        button.setImage(UIImage(named: "home_search"), for: .normal)
        button.setTitle("搜索你想找的内容", for: .normal)
        button.setTitleColor(TertiaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "home_signIn"), for: .normal)
        button.addTarget(self, action: #selector(signInButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var newsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "home_news"), for: .normal)
        button.addTarget(self, action: #selector(newsButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    
    
}
