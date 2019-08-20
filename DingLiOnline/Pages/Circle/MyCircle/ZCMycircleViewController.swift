//
//  ZCMycircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMycircleViewController: ZCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        
        NetworkHelper.postRequestWith(url: kcircleList, params: ["condition": "0","pn":"1","num":"10"], success: { (respons) in
            let data = ZCFocusDataModel(jsonData: respons["data"])
            self.dataArray = data.list
            self.collectionView.reloadData()
        }) { (error) in
            
        }

    }
    
    lazy var collectionView: UICollectionView = {
        let layout = ZCWaterfallFlowLayout.init()
        layout.minimumLineSpacing = FitWidth(10)
        layout.minimumInteritemSpacing = FitWidth(10)
        layout.dataSource = self
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight-TabBarHeight), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = ScrollViewBackGroundColor
        collection.register(ZCMycircleCollectionCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCMycircleCollectionCell.self))
        collection.register(ZCMyCircleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ZCMyCircleHeaderView.self))
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self))
//        collection.contentInset = UIEdgeInsets(top: FitWidth(10), left: FitWidth(12), bottom: FitWidth(10), right: FitWidth(12))
        return collection
    }()
    
    var dataArray:[ZCFocusListModel] = []

}

extension ZCMycircleViewController: ZCWaterfallFlowLayoutDataSource {
    
    /// Return per section's column number(must be greater than 0).
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, numberOfColumnInSection section: NSInteger) -> Int {
        return 2
    }
    
    /// Return per item's height
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, _ itemWidth: CGFloat, heightForItemAtIndexPath: IndexPath) -> CGFloat {
        // 40 - 80 之间随机数
        return CGFloat(arc4random()%80 + 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: FitWidth(110))
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: FitWidth(10), left: FitWidth(12), bottom: FitWidth(10), right: FitWidth(12))
    }
    
}

extension ZCMycircleViewController: UICollectionViewDelegate {
    
}

extension ZCMycircleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCMycircleCollectionCell.self), for: indexPath) as! ZCMycircleCollectionCell
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(ZCMyCircleHeaderView.self), for: indexPath) as! ZCMyCircleHeaderView
            return header
        }else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self), for: indexPath)
            return footer
        }
    }

}


