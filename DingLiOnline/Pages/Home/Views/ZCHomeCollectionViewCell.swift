//
//  ZCHomeCollectionViewCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/6.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCHomeCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.numberOfLines = 2
        self.contentView.backgroundColor = UIColor.random()
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
//        self.contentView.addSubview(avatarImg)
        self.contentView.addSubview(priceLabel)
//        self.contentView.addSubview(zanButton)
        

        
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imgView.snp_bottom).offset(FitWidth(12))
        }

        priceLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp_bottom).offset(FitWidth(8))
            make.bottom.equalToSuperview().inset(FitWidth(20))
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    @objc func zanButtonAction(_ button: UIButton) {
//        if model.likeState {
//            NetworkHelper.postRequestWith(url: kdelUserLike, params: ["likeId":model.id!, "type":"0"], success: { (response) in
//                self.model.likeState = !self.model.likeState
//                self.model.likeCount -= 1
//                button.isSelected = self.model.likeState
//            })
//        }else {
//            NetworkHelper.postRequestWith(url: kaddUserLike, params: ["likeId":model.id!, "type":"0"], success: { (response) in
//                self.model.likeState = !self.model.likeState
//                self.model.likeCount += 1
//                button.isSelected = self.model.likeState
//            })
//        }
//
//    }
//
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }
    
    var model: RecommenedGoodsModel = RecommenedGoodsModel(json: "") {
        willSet {
            imgView.kf.setImage(with: URL(string: newValue.goodimages!))
            titleLabel.text = newValue.name
            priceLabel.attributedText = newValue.priceAtt
            
            
        }
    }
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.setContentHuggingPriority(.defaultLow-100, for: .vertical)
        return view
    }()
    
    let titleLabel = UILabel(textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
    
    
    lazy var avatarImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.layer.cornerRadius = FitWidth(11)
        view.clipsToBounds = true
        return view
    }()
    
    let priceLabel = UILabel(textColor: MinorColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    lazy var zanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_zan_select"), for: .selected)
        button.setImage(UIImage(named: "circle_zan_normal"), for: .normal)
//        button.addTarget(self, action: #selector(zanButtonAction(_:)), for: .touchUpInside)
        return button
    }()
}
