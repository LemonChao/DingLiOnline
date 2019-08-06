//
//  ZCMycircleViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMycircleViewController: ZCBaseViewController {

    lazy var headerView: ZCMyCircleHeaderView = {
        let view = ZCMyCircleHeaderView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(110)))
        return view
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = ZCWaterfallFlowLayout.init()
        layout.minimumLineSpacing = FitWidth(10)
        layout.minimumInteritemSpacing = FitWidth(10)
        layout.dataSource = self
        let collection = UICollectionView(frame: CGRect(x: 0, y: FitWidth(110), w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight-TabBarHeight-FitWidth(110)), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = ScrollViewBackGroundColor
        collection.register(ZCCircleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self))
        collection.contentInset = UIEdgeInsets(top: FitWidth(10), left: FitWidth(12), bottom: FitWidth(10), right: FitWidth(12))
        return collection
    }()
    
    var dataArray:[String] = Array(repeating: "123", count: 50)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(headerView)
        self.view.addSubview(collectionView)
    }
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
    
}

extension ZCMycircleViewController: UICollectionViewDelegate {
    
}

extension ZCMycircleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self), for: indexPath) as! ZCCircleCollectionViewCell
        cell.titleLabel.text = "\(cell.frame)-{\(indexPath.section), \(indexPath.row)}"
        return cell
        
    }
}

