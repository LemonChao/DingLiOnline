//
//  ZCMycircleCollectionCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/16.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMycircleCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.numberOfLines = 2
        titleLabel.text = "大家给掌掌眼，看看怎么 样，刚从鬼市淘回来的..."
        self.contentView.backgroundColor = UIColor.random()
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(deleteButton)
        self.contentView.addSubview(zanButton)
        
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imgView.snp_bottom).offset(FitWidth(12))
        }
        deleteButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp_bottom).offset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(22), height: FitWidth(22)))
            make.bottom.equalToSuperview().inset(FitWidth(10))
        }
        zanButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(FitWidth(5))
            make.centerY.equalTo(deleteButton)
        }
        
        self.layoutIfNeeded()
        zanButton.titleEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func zanButtonAction(_ button: UIButton) {
        if model.likeState {
            NetworkHelper.postRequestWith(url: kdelUserLike, params: ["likeId":model.id!, "type":"0"], success: { (response) in
                self.model.likeState = !self.model.likeState
                self.model.likeCount -= 1
                button.setTitle(String(self.model.likeCount), for: .normal)
                button.setTitle(String(self.model.likeCount), for: .selected)
                button.isSelected = self.model.likeState
            })
        }else {
            NetworkHelper.postRequestWith(url: kaddUserLike, params: ["likeId":model.id!, "type":"0"], success: { (response) in
                self.model.likeState = !self.model.likeState
                self.model.likeCount += 1
                button.setTitle(String(self.model.likeCount), for: .normal)
                button.setTitle(String(self.model.likeCount), for: .selected)
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
            zanButton.setTitle(String(newValue.likeCount), for: .normal)
            zanButton.setTitle(String(newValue.likeCount), for: .selected)
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
    
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_delete"), for: .normal)
        return button
    }()
    
    
    lazy var zanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_zan_select"), for: .selected)
        button.setImage(UIImage(named: "circle_zan_normal"), for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.setTitleColor(GeneralRedColor, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        button.addTarget(self, action: #selector(zanButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    
    
}
