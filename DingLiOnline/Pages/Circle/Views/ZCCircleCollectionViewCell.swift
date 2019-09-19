//
//  ZCCircleCollectionViewCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCCircleCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.numberOfLines = 2
//        titleLabel.text = "大家给掌掌眼，看看怎么 样，刚从鬼市淘回来的..."
//        nameLabel.text = "铁树开花"
        self.contentView.backgroundColor = UIColor.random()
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(avatarImg)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(zanButton)
        
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imgView.snp_bottom).offset(FitWidth(12))
        }
        avatarImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp_bottom).offset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(22), height: FitWidth(22)))
            make.bottom.equalToSuperview().inset(FitWidth(10))
        }
        zanButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(FitWidth(5))
            make.centerY.equalTo(avatarImg)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImg.snp_right).offset(FitWidth(5))
            make.right.equalTo(zanButton.snp_left).offset(FitWidth(-10))
            make.centerY.equalTo(avatarImg)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func zanButtonAction(_ button: UIButton) {
        if model.likeState {
            NetworkHelper.postRequestWith(url: kdelUserLike, params: ["likeId":model.id!, "type":"0"], success: { (response) in
                self.model.likeState = !self.model.likeState
                self.model.likeCount -= 1
                button.isSelected = self.model.likeState
            })
        }else {
            NetworkHelper.postRequestWith(url: kaddUserLike, params: ["likeId":model.id!, "type":"0"], success: { (response) in
                self.model.likeState = !self.model.likeState
                self.model.likeCount += 1
                button.isSelected = self.model.likeState
            })
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }

    var model: ZCFocusListModel = ZCFocusListModel(jsonData: "") {
        willSet {
            let imgUrlStr = newValue.imagess.first ?? ""
            imgView.kf.setImage(with: URL(string: imgUrlStr))
            titleLabel.text = newValue.content
            avatarImg.kf.setImage(with: URL(string: newValue.litpic))
//            nameLabel.text = newValue.vxName
            nameLabel.text = "大家给掌掌眼，看看怎么 样，刚从鬼市淘回来的"
            zanButton.isSelected = newValue.likeState
            
            
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
    
    let nameLabel = UILabel(textColor: MinorColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    
    lazy var zanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_zan_select"), for: .selected)
        button.setImage(UIImage(named: "circle_zan_normal"), for: .normal)
        button.addTarget(self, action: #selector(zanButtonAction(_:)), for: .touchUpInside)
        return button
    }()
}
