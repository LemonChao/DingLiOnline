//
//  ZCCircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCCircleViewController: ZCBaseViewController {

    lazy var collectionView: UICollectionView = {
        let layout = ZCWaterfallFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.dataSource = self
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight-TabBarHeight), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ZCCircleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self))
        return collection
        
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight-TabBarHeight), collectionViewLayout: layout)
//        collection.dataSource = self
//        collection.delegate = self
//        collection.register(ZCCircleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self))
//        return collection

    }()
    
    var dataArray:[String] = Array(repeating: "123", count: 50)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
    }    
    
    
}

extension ZCCircleViewController: ZCWaterfallFlowLayoutDataSource {
    
    /// Return per section's column number(must be greater than 0).

    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, numberOfColumnInSection section: NSInteger) -> Int {
        return 2
    }
    
    /// Return per item's height
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, _ itemWidth: CGFloat, heightForItemAtIndexPath: IndexPath) -> CGFloat {
        // 40 - 80 之间随机数
        return CGFloat(arc4random()%40 + 40)
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
        cell.titleLabel.text = "\(cell.frame)-{\(indexPath.section), \(indexPath.row)}"
        return cell
        
    }
    
}

