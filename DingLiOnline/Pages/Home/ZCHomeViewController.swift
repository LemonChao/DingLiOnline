//
//  ZCHomeViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCHomeViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        
//        ZCPageGuideView.addPageGuideView()
    }
    

    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.setBackButton(withImage: UIImage())
        let navigationBarView = ZCHomeNavigationBar(frame: CGRect(x: 0, y: StatusBarHeight, w: SCREEN_WIDTH, h: 44))
        self.customNavBar.addSubview(navigationBarView)
    }
    
    override func bindViewModel() {
        viewModel.netAction.apply().start()
        
        viewModel.netAction.values.observeValues { (success) in
            
            if success {
                self.collectionView.reloadData()
            }
            
        }
        
        viewModel.netAction.errors.observeValues { (error) in
            
        }
        
        
        
    }
    
    
    
    lazy var collectionView: UICollectionView = {
        let layout = ZCWaterfallFlowLayout.init()
        layout.minimumLineSpacing = FitWidth(10)
        layout.minimumInteritemSpacing = FitWidth(10)
        layout.dataSource = self
        let collection = UICollectionView(frame: CGRect(x: 0, y: NavBarHeight, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight-NavBarHeight), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.register(ZCHomeCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ZCHomeCollectionViewCell.self))
        collection.register(ZCHomeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ZCHomeSectionHeaderView")
        collection.register(ZCHomeSectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ZCHomeSectionFooterView_id")
        collection.contentInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        return collection
    }()
    
    var dataArray:[String] = Array(repeating: "123", count: 50)
    var viewModel = ZCHomeViewModel()
    
    
}


extension ZCHomeViewController: ZCWaterfallFlowLayoutDataSource {
    
    /// Return per section's column number(must be greater than 0).
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, numberOfColumnInSection section: NSInteger) -> Int {
        return 2
    }
    
    /// Return per item's height
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, _ itemWidth: CGFloat, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let model = viewModel.model!.recommenedGoodsList[indexPath.row]

        return model.rowHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: FitWidth(852))
    }
    
    func collectionView(_ collectionView: UICollectionView, _ layout: ZCWaterfallFlowLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: FitWidth(16))
    }
    
}

extension ZCHomeViewController: UICollectionViewDelegate {
    
    
    
}

extension ZCHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let model = viewModel.model {
            return model.recommenedGoodsList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ZCHomeCollectionViewCell.self), for: indexPath) as! ZCHomeCollectionViewCell
        cell.titleLabel.text = "\(cell.frame)-{\(indexPath.section), \(indexPath.row)}"
        
        let model = viewModel.model!.recommenedGoodsList[indexPath.row]
        cell.model = model
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ZCHomeSectionHeaderView", for: indexPath) as! ZCHomeSectionHeaderView
            if let model = viewModel.model {
                header.model = model
            }
            return header
        }else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ZCHomeSectionFooterView_id", for: indexPath)
        }
    }
}

