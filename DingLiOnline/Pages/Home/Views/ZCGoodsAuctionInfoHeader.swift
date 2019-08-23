//
//  ZCGoodsAuctionInfoHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/23.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsAuctionInfoHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: FitWidth(7), left: FitWidth(12), bottom: FitWidth(7), right: FitWidth(12)))
            make.height.equalTo(FitWidth(108))
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        layout.estimatedItemSize = CGSize(width: floor((SCREEN_WIDTH-FitWidth(24))/2), height: FitWidth(27))
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(ZCGoodsAuctionInfoCell.self, forCellWithReuseIdentifier: "ZCGoodsAuctionInfoCell_id")
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    
}

extension ZCGoodsAuctionInfoHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZCGoodsAuctionInfoCell_id", for: indexPath)
        return cell
    }
    
}

extension ZCGoodsAuctionInfoHeader: UICollectionViewDelegate {
    
    
    
}

