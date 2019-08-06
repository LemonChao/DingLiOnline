//
//  ZCHomeSectionHeaderView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/6.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCHomeSectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(cycleScrollView)
        self.addSubview(marqueeView)
        self.addSubview(titleView)
        self.addSubview(auctionView)
        self.addSubview(auctionCollectionView)
        self.addSubview(moreAuctionButton)
        self.addSubview(tuijianTitle)
        
        
        let margin: CGFloat = 12
        
        cycleScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(FitWidth(margin))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(210))
        }
        
        marqueeView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleScrollView.snp_bottom).offset(FitWidth(margin))
            make.left.right.equalToSuperview().inset(FitWidth(margin))
            make.height.equalTo(FitWidth(32))
        }
        
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(marqueeView.snp_bottom).offset(FitWidth(30))
            make.centerX.equalToSuperview()
            make.height.equalTo(FitWidth(20))
        }
        
        auctionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(margin))
            make.top.equalTo(titleView.snp_bottom).offset(FitWidth(20))
            make.height.equalTo(FitWidth(195))
        }
        
        auctionCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(auctionView.snp_bottom).offset(FitWidth(margin))
            make.left.right.equalToSuperview().inset(FitWidth(margin))
            make.height.equalTo(FitWidth(202))
        }
        
        moreAuctionButton.snp.makeConstraints { (make) in
            make.top.equalTo(auctionCollectionView.snp_bottom).offset(FitWidth(10))
            make.left.equalToSuperview().inset(FitWidth(margin))
            make.height.equalTo(FitWidth(12))
        }
        
        tuijianTitle.snp.makeConstraints { (make) in
            make.top.equalTo(moreAuctionButton.snp_bottom).offset(FitWidth(14))
            make.centerX.equalToSuperview()
            make.height.equalTo(FitWidth(18))
//            make.bottom.equalToSuperview().inset(FitWidth(20))
        }
        
        //12 210 12 32 30 20 12 195 12 212 10 12 14 18 20 = 821
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    

    
    lazy var cycleScrollView: UIView = {
        let cycleView = UIView()
        return cycleView
    }()
    
    lazy var marqueeView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "精选专场拍卖会"
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(18))
        return label
    }()
    
    lazy var auctionView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var auctionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collection
    }()
    
    lazy var moreAuctionButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("更多拍卖会", for: .normal)
        view.setTitleColor(TertiaryColor, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        return view
    }()
    
    lazy var tuijianTitle: UILabel = {
        let label = UILabel()
        label.text = "今日推荐"
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(18))
        return label
    }()

    
}
