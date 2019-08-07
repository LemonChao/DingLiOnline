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
        
                
        cycleScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(FitWidth(12))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(210))
        }
        
        marqueeView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleScrollView.snp_bottom).offset(FitWidth(12))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(32))
        }
        
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(marqueeView.snp_bottom).offset(FitWidth(30))
            make.centerX.equalToSuperview()
            make.height.equalTo(FitWidth(20))
        }
        
        auctionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp_bottom).offset(FitWidth(20))
            make.height.equalTo(FitWidth(210))
        }
        
        auctionCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(auctionView.snp_bottom).offset(FitWidth(10))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(218))
        }
        
        moreAuctionButton.snp.makeConstraints { (make) in
            make.top.equalTo(auctionCollectionView.snp_bottom).offset(FitWidth(10))
            make.left.equalToSuperview()
            make.height.equalTo(FitWidth(12))
        }
        
        tuijianTitle.snp.makeConstraints { (make) in
            make.top.equalTo(moreAuctionButton.snp_bottom).offset(FitWidth(14))
            make.centerX.equalToSuperview()
            make.height.equalTo(FitWidth(18))
//            make.bottom.equalToSuperview().inset(FitWidth(20))
        }
        
        //12 210 12 32 30 20 12 210 12 103*2+12(212) 10 12 14 18 20 = 862
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    

    
    lazy var cycleScrollView: UIView = {
        let cycleView = UIView()
        cycleView.backgroundColor = LineColor
        return cycleView
    }()
    
    lazy var marqueeView: UIView = {
        let view = UIView()
        view.backgroundColor = RGBA(245, 245, 245, 1)
        view.layer.cornerRadius = FitWidth(4)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "精选专场拍卖会"
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(18))
        return label
    }()
    
    lazy var auctionView: ZCHomeAuctionRecommendView = {
        let view = ZCHomeAuctionRecommendView()
        return view
    }()
    
    lazy var auctionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-FitWidth(35))/2, height: FitWidth(103))
        layout.minimumLineSpacing = FitWidth(12)
        layout.minimumInteritemSpacing = FitWidth(10)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ZCHomeAuctionCell.self, forCellWithReuseIdentifier: "ZCHomeAuctionCell_id")
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = UIColor.white
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

extension ZCHomeSectionHeaderView: UICollectionViewDelegate {
    
}

extension ZCHomeSectionHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZCHomeAuctionCell_id", for: indexPath) as! ZCHomeAuctionCell
        return cell
    }
    
    
}
