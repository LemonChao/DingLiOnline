//
//  ZCClassifyRightController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/2.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCClassifyRightController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(colltionView)
        self.customNavBar.removeFromSuperview()
    }
    

    lazy var colltionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = FitWidth(30)
//        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH-FitWidth(84), height: FitWidth(30))
//        layout.footerReferenceSize = CGSize.zero
        layout.itemSize = CGSize(width: FitWidth(55), height: FitWidth(85))
        layout.sectionInset = UIEdgeInsets(top: 0, left: FitWidth(10), bottom: 0, right: FitWidth(10))
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-FitWidth(84), height: SCREEN_HEIGHT-NavBarHeight-TabBarHeight), collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.contentInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        view.register(ZCClassifyRightCollectionCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCClassifyRightCollectionCell.self))
//        view.register(ZCClassifyCollectionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ZCClassifyCollectionSectionHeader.self))
//        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UICollectionView.elementKindSectionHeader)

        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    var dataArray:[ZCClassifySubModel] = [] {
        didSet {
            self.colltionView.reloadData()
        }
        
    }
    

}


extension ZCClassifyRightController: UICollectionViewDataSource {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCClassifyRightCollectionCell.self), for: indexPath) as! ZCClassifyRightCollectionCell
        cell.model = dataArray[indexPath.row]
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let view: UICollectionReusableView!
//
//        if kind == UICollectionView.elementKindSectionHeader {
//            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(ZCClassifyCollectionSectionHeader.self), for: indexPath) as! ZCClassifyCollectionSectionHeader
//            view.backgroundColor = UIColor.orange
//            return view
//        }else {
//            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionView.elementKindSectionFooter, for: indexPath)
//        }
//        return view
//    }
//
    
}


extension ZCClassifyRightController: UICollectionViewDelegateFlowLayout {
    
}

