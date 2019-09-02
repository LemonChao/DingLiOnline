//
//  ZCGridPictureView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
/// 微信朋友圈图片布局1大图 4宫格 6 宫格 9宫格

struct GridLayoutConfig {
    var count: Int = 0
    var itemSize: CGSize = CGSize.zero
    var lineSpacing: CGFloat = 0
    var interitemSpacing: CGFloat = 0
    var collectionFrame = CGRect.zero
    
    init(_ aCount: Int) {
        count = aCount
        switch aCount {
        case 0:
            itemSize = CGSize.zero
            lineSpacing = 0
            interitemSpacing = 0
            collectionFrame = CGRect.zero
        case 1:
            itemSize = CGSize(width: FitWidth(350), height: FitWidth(109))
            lineSpacing = 0
            interitemSpacing = 0
            collectionFrame = CGRect(x: 0, y: 0, w: itemSize.width, h: itemSize.height)
        case 4:
            itemSize = CGSize(width: FitWidth(130), height: FitWidth(130))
            lineSpacing = FitWidth(10)
            interitemSpacing = FitWidth(12)
            collectionFrame = CGRect(x: 0, y: 0, w: itemSize.width * 2 + interitemSpacing, h: itemSize.height * 2 + lineSpacing)

       default:
        itemSize = CGSize(width: FitWidth(96), height: FitWidth(96))
        lineSpacing = FitWidth(10)
        interitemSpacing = FitWidth(12)
        let line: CGFloat = CGFloat((aCount-1) / 3) + 1
        let file: CGFloat = aCount >= 3 ? 3 : 2
        
        collectionFrame = CGRect(x: 0, y: 0, w: itemSize.width*file+interitemSpacing*(file-1), h: itemSize.height*line+(line-1)*lineSpacing)
        }
        
        
    }
    
    
}


class ZCGridPictureView: UIView {
    
    var config = GridLayoutConfig(0)
    var photos: [String] = [] {
        willSet {
            config = GridLayoutConfig(newValue.count)
        }
        
        didSet {
            collectionView.reloadData()
            let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            self.h = height
            self.superview?.layoutIfNeeded()
        }
        
    }
    
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ZCGirdPhotosViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCGirdPhotosViewCell.self))
        collection.backgroundColor = UIColor.white
        collection.bounces = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension ZCGridPictureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCGirdPhotosViewCell.self), for: indexPath) as! ZCGirdPhotosViewCell
        cell.setImage(urlStr: photos[indexPath.row])
        return cell
    }
    
    
}

extension ZCGridPictureView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.config.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.config.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.config.interitemSpacing
    }
    
}

extension ZCGridPictureView: ZCWaterfallFlowLayoutDataSource {
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, numberOfColumnInSection section: NSInteger) -> Int {
        
        if config.count == 4 {
            return 2
        }else if config.count >= 3 {
            return 3
        } else {
            return config.count % 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, _ itemWidth: CGFloat, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return config.itemSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return config.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return config.interitemSpacing
    }
    
}
