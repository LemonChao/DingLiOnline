//
//  ZCGoodsAuctionRecommendHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/23.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsAuctionRecommendHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        let redLine = UIView(color: GeneralRedColor)
        let titleLab = UILabel(text: "更多推荐", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        self.contentView.addSubview(redLine)
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(collectionView)
        
        redLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalToSuperview().inset(FitWidth(17))
            make.size.equalTo(CGSize(width: 2, height: 10))
        }
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(redLine)
            make.left.equalTo(redLine.snp_right).offset(FitWidth(5))
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(titleLab.snp_bottom).offset(FitWidth(10))
            make.height.equalTo(itemWidth*2 + FitWidth(10))
            make.bottom.equalToSuperview().inset(FitWidth(15))
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemWidth = floor((SCREEN_WIDTH-FitWidth(48))/3)
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = FitWidth(10)
        layout.minimumInteritemSpacing = FitWidth(12)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(ZCGoodsAuctionRecommendCell.self, forCellWithReuseIdentifier: "ZCGoodsAuctionRecommendCell_id")
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

}


extension ZCGoodsAuctionRecommendHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ZCGoodsAuctionRecommendCell_id", for: indexPath)
    }
    
    
}

extension ZCGoodsAuctionRecommendHeader: UICollectionViewDelegate {
    
}

