//
//  ZCFocusTableViewCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/29.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCFocusTableViewCell: UITableViewCell {

    var model: Any {
        set {
            nameLabel.text = "星月菩提"
            levelImgView.image = UIImage(named: "circle_membership")
            contentLabel.text = "于是我们领教了世界是何等凶顽，同时又得知世界也可以变得温存和美好。 于是我们领教了世界是何等凶顽，同时又得知世界也可以变得温存和美好。"
            topicButton.setTitle("#笙歌爷爷", for: .normal)
            timeLabel.text = "1小时前"
            gridPictureView.photos = Array(repeating: "1", count: Int(arc4random() % 8 + 1))
            
            collectButton.imagePosition(.Left, spacing: FitWidth(6))
            zanButton.imagePosition(.Left, spacing: FitWidth(6))
            
            gridPictureView.snp.updateConstraints { (make) in
                make.size.equalTo(gridPictureView.config.collectionFrame.size)
            }

            self.superview?.layoutIfNeeded()
        }
        get {
            return "12"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self.contentView.addSubview(avatarImgView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(levelImgView)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(gridPictureView)
        self.contentView.addSubview(topicButton)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(shareButton)
        self.contentView.addSubview(zanButton)
        self.contentView.addSubview(collectButton)
//        self.contentView.addSubview(commentButton)
//        self.contentView.addSubview(rewardButton)
        self.contentView.addSubview(lineView)
        
        let margin: CGFloat = 12
        avatarImgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(margin)
            make.top.equalToSuperview().inset(15)
            make.size.equalTo(CGSize(width: FitWidth(40), height: FitWidth(40)))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarImgView)
            make.left.equalTo(avatarImgView.snp_right).offset(FitWidth(7))
        }
        levelImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_right).offset(FitWidth(6))
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(margin)
            make.top.equalTo(avatarImgView.snp_bottom).offset(FitWidth(10))
        }
        gridPictureView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(margin)
            make.top.equalTo(contentLabel.snp_bottom).offset(FitWidth(10))
            make.size.equalTo(CGSize.zero)
        }
        
        topicButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(margin)
            make.top.equalTo(gridPictureView.snp_bottom).offset(FitWidth(10))
            make.height.equalTo(FitWidth(24))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(topicButton)
            make.right.equalToSuperview().inset(margin)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(margin)
            make.top.equalTo(topicButton.snp_bottom).offset(FitWidth(10))
        }
        
//        rewardButton.snp.makeConstraints { (make) in
//            make.right.equalToSuperview().inset(margin)
//            make.centerY.equalTo(shareButton)
//        }
//
//        commentButton.snp.makeConstraints { (make) in
//            make.centerY.equalTo(shareButton)
//            make.right.equalTo(rewardButton.snp_left).offset(-FitWidth(24))
//        }
        
        collectButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(margin)
            make.centerY.equalTo(shareButton)
        }

        zanButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(shareButton)
            make.right.equalTo(collectButton.snp_left).offset(-FitWidth(24))
        }

        
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(shareButton.snp_bottom).offset(FitWidth(18))
            make.height.equalTo(FitWidth(10))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func commentButtonAction(button: UIButton) {
    
    }
    
    @objc func shareButtonAction(button: UIButton) {
        lineView.snp.updateConstraints { (make) in
            make.height.equalTo(FitWidth(50))
        }
        (self.superview as! UITableView).reloadData()
    }
    
    @objc func zanButtonAction(button: UIButton) {
        
    }
    @objc func collectionButtonAction(button: UIButton) {
        
    }

    @objc func rewardButtonAction(button: UIButton) {
        
    }

    
    
    lazy var avatarImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.layer.cornerRadius = FitWidth(20)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: FontSize(15))
        view.textColor = ImportantColor
        return view
    }()
    
    lazy var levelImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: FontSize(15))
        view.textColor = ImportantColor
        view.numberOfLines = 0
        return view
    }()
    
    lazy var rewardButton: UIButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(6))
        button.setImage(UIImage(named: "circle_reward"), for: .normal)
        button.setTitle("打赏", for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.addTarget(self, action: #selector(rewardButtonAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(6))
        button.setImage(UIImage(named: "circle_comment"), for: .normal)
        button.setTitle("0", for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.addTarget(self, action: #selector(commentButtonAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var collectButton: UIButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(6))
        button.setImage(UIImage(named: "circle_collect_normal"), for: .normal)
        button.setImage(UIImage(named: "circle_collect_select"), for: .selected)
        button.setTitle("收藏", for: .normal)
        button.setTitle("收藏", for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.addTarget(self, action: #selector(collectionButtonAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var zanButton: ResizeSpacingButton = {
        let button = ResizeSpacingButton(position: .Left, spacing: FitWidth(6))
        button.setImage(UIImage(named: "circle_zan_normal"), for: .normal)
        button.setImage(UIImage(named: "circle_zan_select"), for: .selected)
        button.setTitle("0", for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.addTarget(self, action: #selector(zanButtonAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "circle_share"), for: .normal)
        button.addTarget(self, action: #selector(shareButtonAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = LineColor
        return view
    }()
    
    lazy var gridPictureView: ZCGridPictureView = {
        let view = ZCGridPictureView()
        return view
    }()
    
    lazy var topicButton: ContentInsetButton = {
        let button = ContentInsetButton(inset: UIEdgeInsets(top: FitWidth(6), left: FitWidth(12), bottom: FitWidth(12), right: FitWidth(6)))
        button.setTitleColor(AssistBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FitWidth(12))
        button.layer.cornerRadius = FitWidth(12)
        button.layer.borderColor = AssistBlue.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = TertiaryColor
        view.font = UIFont.systemFont(ofSize: FontSize(12))
        return view
    }()
}
