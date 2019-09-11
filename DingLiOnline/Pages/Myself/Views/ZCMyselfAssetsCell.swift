//
//  ZCMyselfAssetsCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/8.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyselfAssetsCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(cornerBgView)
        cornerBgView.addSubview(collectionView)
        
        cornerBgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: FitWidth(12), bottom: FitWidth(8), right: FitWidth(12)))
        }

        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: FitWidth(15), left: FitWidth(10), bottom: FitWidth(10), right: FitWidth(10)))
            make.height.equalTo(FitWidth(115))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = FitWidth(15)
        layout.minimumInteritemSpacing = FitWidth(30)
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-FitWidth(104))/3, height: FitWidth(50))//100+44
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.register(ZCMyselfAssetsCollectionCell.self, forCellWithReuseIdentifier: "ZCMyselfAssetsCollectionCell")
        return collection
    }()
    
    lazy var cornerBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.addShadow(offset: CGSize(width: 0, height: 2), radius: 3, color: GeneralRedColor, opacity: 0.1, cornerRadius: FitWidth(5))
        return view
    }()
    
    lazy var dataArray: [[String:String]] = {
        var array = [[String:String]]()
        let titles = ["保证金管理","我的余额","我的积分","我要推广","我的银行卡","我的委托"]
        let imgNames = ["baozhengjinguanli","wodeyue","jifen","woyaotuiguang","zhifuguanli","wodeweituo"]
        for (index, value) in titles.enumerated() {
            let item: [String: String] = ["title": titles[index], "imgName": imgNames[index]]
            array.append(item)
        }
        
        return array
    }()

}

extension ZCMyselfAssetsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZCMyselfAssetsCollectionCell", for: indexPath) as! ZCMyselfAssetsCollectionCell
        cell.dictionary = dataArray[indexPath.row]
        return cell
    }
    
    
}



extension ZCMyselfAssetsCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.viewController?.navigationController?.pushViewController(ZCMyCardViewController(), animated: true)
        case 1:
            self.viewController?.navigationController?.pushViewController(ZCMyBalanceViewController(), animated: true)
        case 2:
            self.viewController?.navigationController?.pushViewController(ZCMyBalanceViewController(), animated: true)
        case 3:
            self.viewController?.navigationController?.pushViewController(ZCMyBalanceViewController(), animated: true)
        case 4:
            self.viewController?.navigationController?.pushViewController(ZCMyCardViewController(), animated: true)
        case 5:
            self.viewController?.navigationController?.pushViewController(ZCMyBalanceViewController(), animated: true)
        default: break
        }
        
        
    }
    
}


