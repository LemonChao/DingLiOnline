//
//  ZCHomeViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCHomeViewController: ZCBaseViewController {
    lazy var collectionView: UICollectionView = {
        let layout = ZCWaterfallFlowLayout.init()
        layout.minimumLineSpacing = FitWidth(10)
        layout.minimumInteritemSpacing = FitWidth(10)
        layout.dataSource = self
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.register(ZCCircleCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self))
        collection.register(ZCHomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ZCHomeSectionHeaderView")
        collection.contentInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        return collection
    }()
    
    var dataArray:[String] = Array(repeating: "123", count: 50)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
    }
    

    override func configCustomNav() {
        self.view.addSubview(customNavBar)
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        let navigationBarView = ZCHomeNavigationBar(frame: CGRect(x: 0, y: StatusBarHeight, w: SCREEN_WIDTH, h: 44))
//        self.navigationController?.navigationBar.addSubview(navigationBarView)
        self.customNavBar.addSubview(navigationBarView)
    }
}


extension ZCHomeViewController: ZCWaterfallFlowLayoutDataSource {
    
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
        return CGSize(width: SCREEN_WIDTH, height: FitWidth(852))
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
}

extension ZCHomeViewController: UICollectionViewDelegate {
    
    
    
}

extension ZCHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCCircleCollectionViewCell.self), for: indexPath) as! ZCCircleCollectionViewCell
        cell.titleLabel.text = "\(cell.frame)-{\(indexPath.section), \(indexPath.row)}"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ZCHomeSectionHeaderView", for: indexPath) as! ZCHomeSectionHeaderView
            return header
        }else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self), for: indexPath)
        }
    }
}

