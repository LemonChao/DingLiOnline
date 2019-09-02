//
//  ZCCircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCCircleViewController: ZCBaseViewController {

    
    
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
        collection.backgroundColor = UIColor.white
        collection.register(ZCCircleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self))
        collection.contentInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        return collection
    }()
    
    var dataArray:[ZCFocusListModel] = []
}

extension ZCCircleViewController: ZCWaterfallFlowLayoutDataSource {
    
    /// Return per section's column number(must be greater than 0).

    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, numberOfColumnInSection section: NSInteger) -> Int {
        return 2
    }
    
    /// Return per item's height
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, _ itemWidth: CGFloat, heightForItemAt indexPath: IndexPath) -> CGFloat {
        // 100 - 180 之间随机数
        return CGFloat(arc4random()%80 + 100) + FitWidth(46)
    }

}

extension ZCCircleViewController: UICollectionViewDelegate {
    
}

extension ZCCircleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self), for: indexPath) as! ZCCircleCollectionViewCell
        cell.model = dataArray[indexPath.row]
        return cell
        
    }
    
}

