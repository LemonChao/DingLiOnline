//
//  ZCHomeSectionHeaderView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/6.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCHomeSectionHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(cycleScrollView)
        self.addSubview(marqueeBG)
        marqueeBG.addSubview(noticeButton)
        marqueeBG.addSubview(marqueeView)
        self.addSubview(titleView)
        self.addSubview(auctionView)
        self.addSubview(auctionCollectionView)
        self.addSubview(moreAuctionButton)
        self.addSubview(tuijianTitle)
        
                
        cycleScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(210))
        }
        
        marqueeBG.snp.makeConstraints { (make) in
            make.top.equalTo(cycleScrollView.snp_bottom).offset(FitWidth(12))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(32))
        }
        
        noticeButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
            make.width.equalTo(FitWidth(44))
        }
        
        marqueeView.snp.makeConstraints { (make) in
            make.left.equalTo(noticeButton.snp_right).offset(FitWidth(6))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(25))
        }
        
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(marqueeView.snp_bottom).offset(FitWidth(30))
            make.centerX.equalToSuperview()
            make.height.equalTo(FitWidth(20))
        }
        
        auctionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp_bottom).offset(FitWidth(20))
            make.height.equalTo(FitWidth(210))
        }
        
        auctionCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(auctionView.snp_bottom).offset(FitWidth(10))
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(218))
        }
        
        moreAuctionButton.snp.makeConstraints { (make) in
            make.top.equalTo(auctionCollectionView.snp_bottom).offset(FitWidth(10))
            make.left.equalToSuperview()
            make.height.equalTo(FitWidth(12))
        }
        
        tuijianTitle.snp.makeConstraints { (make) in
            make.top.equalTo(moreAuctionButton.snp_bottom).offset(FitWidth(14))
            make.centerX.equalToSuperview()
            make.height.equalTo(FitWidth(18))
//            make.bottom.equalToSuperview().inset(FitWidth(20))
        }
        
        noticeButton.imagePosition(.Left, margin: 0)
        //12 210 12 32 30 20 12 210 12 103*2+12(212) 10 12 14 18 20 = 862
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ZCHomeModel! {
        didSet {
            marqueeView.titleArray = model.messageList
            
            var imgArray: [String] = []
            for admodel in model.adlist {
                imgArray.append(admodel.image)
            }
            cycleScrollView.imageURLStringsGroup = imgArray
            
//            auctionView.model = model.aucList.first
            auctionCollectionView.reloadData()
            
        }
    }
    
    
    
    
    
    
    lazy var cycleScrollView: SDCycleScrollView = {
        let cycle = SDCycleScrollView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(210)), delegate: self, placeholderImage: nil)!
        cycle.autoScrollTimeInterval = 4
        cycle.backgroundColor = LineColor
        cycle.bannerImageViewContentMode = UIView.ContentMode.scaleAspectFill
        cycle.showPageControl = false
        return cycle
    }()

    lazy var noticeButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(5))
        button.setImage(UIImage(named: "home_noteNews"), for: .normal)
        button.setTitle("喜讯", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize(12))
        button.setTitleColor(PrimaryColor, for: .normal)
        return button
    }()
    
    lazy var marqueeBG: UIView = {
        let marqueeBG = UIView(color: RGBA(245, 245, 245, 1))
        marqueeBG.layer.cornerRadius = FitWidth(4)
        marqueeBG.clipsToBounds = true
        return marqueeBG
    }()
    
    lazy var marqueeView: ZCMarqueeView = {
        let view = ZCMarqueeView(cellSize:CGSize(width: SCREEN_WIDTH-FitWidth(98), height: FitWidth(25)), titles: [])
        view.scrollDirection = ZCMarqueeView.ScrollDirection.down
        view.scrollStyle = ZCMarqueeView.ScrollStyle.intermittent
        view.timeInterval = 4
        return view
    }()
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "精选专场拍卖会"
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(18))
        return label
    }()
    
    lazy var auctionView: ZCHomeAuctionRecommendView = {
        let view = ZCHomeAuctionRecommendView()
        return view
    }()
    
    lazy var auctionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-FitWidth(35))/2, height: FitWidth(103))
        layout.minimumLineSpacing = FitWidth(12)
        layout.minimumInteritemSpacing = FitWidth(10)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ZCHomeAuctionCell.self, forCellWithReuseIdentifier: "ZCHomeAuctionCell_id")
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = UIColor.white
        return collection
    }()
    
    lazy var moreAuctionButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("更多拍卖会", for: .normal)
        view.setTitleColor(TertiaryColor, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        return view
    }()
    
    lazy var tuijianTitle: UILabel = {
        let label = UILabel()
        label.text = "今日推荐"
        label.textColor = PrimaryColor
        label.font = UIFont.boldSystemFont(ofSize: FontSize(18))
        return label
    }()

    
}

extension ZCHomeSectionHeaderView: UICollectionViewDelegate {
    
}

extension ZCHomeSectionHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.model != nil {
            return self.model.aucList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZCHomeAuctionCell_id", for: indexPath) as! ZCHomeAuctionCell
        cell.model = model.aucList[indexPath.row]
        return cell
    }
    
}

extension ZCHomeSectionHeaderView: SDCycleScrollViewDelegate {
    
}


class ZCHomeSectionFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel(text: "我是有底线的呦~", textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)), aligment: .center, lines: 1, backgroundColor: UIColor.clear)
        label.frame = CGRect(x: 0, y: 0, w: frame.width, h: frame.height)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


