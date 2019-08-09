//
//  ZCMyselfOrderCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/8.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyselfOrderCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(cornerBgView)
        cornerBgView.addSubview(orderLabel)
        cornerBgView.addSubview(allOrderButton)
        cornerBgView.addSubview(lineView)
        cornerBgView.addSubview(stackView)
        
        cornerBgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: FitWidth(12), bottom: FitWidth(8), right: FitWidth(12)))
        }
        orderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(FitWidth(16))
            make.left.equalTo(FitWidth(10))
        }
        allOrderButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(orderLabel)
            make.right.equalToSuperview().inset(FitWidth(10))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(orderLabel.snp_bottom).offset(FitWidth(16))
            make.height.equalTo(0.8)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(10))
            make.top.equalTo(lineView.snp.bottom).offset(FitWidth(15))
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-FitWidth(44), height: FitWidth(48)))
            make.bottom.equalToSuperview().inset(FitWidth(10))
        }
        
//        allOrderButton.imagePosition(.Right, spacing: FitWidth(6))
//        for button in self.stackView.arrangedSubviews {
//            (button as! UIButton).imagePosition(.Top, spacing: FitWidth(8))
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func allOrderButtonAction(_ button: ResizeSpacingButton) {
        
    }
    
    var model: String = "" {
        willSet {
            self.layoutIfNeeded()
            allOrderButton.imagePosition(.Right, spacing: FitWidth(6))
            for button in self.stackView.arrangedSubviews {
                button.size = CGSize(width: (SCREEN_WIDTH-FitWidth(44))/5, height: FitWidth(48))
                (button as! UIButton).imagePosition(.Top, margin: 0)
            }
        }
    }
    
    
    
    lazy var cornerBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.addShadow(offset: CGSize(width: 0, height: 2), radius: 3, color: GeneralRedColor, opacity: 0.1, cornerRadius: FitWidth(5))
        return view
    }()

    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = "我的订单"
        label.textColor = ImportantColor
        label.font = UIFont.systemFont(ofSize: FitWidth(18))
        return label
    }()
    
    lazy var allOrderButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitleColor(TertiaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.setTitle("查看全部订单", for: .normal)
        button.setImage(UIImage(named: "circle_arrowRight_lightGray"), for: .normal)
        button.addTarget(self, action: #selector(allOrderButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = LineColor
        return line
    }()
    
    lazy var stackView: UIStackView = {
//        let titls = ["待支付","待发货","待收货","已完成","退/换货"]
//        let images = ["daifukuan","daifahuo","daishouhuo","yiwancheng","tuikuan"]
        let titls = ["待支付","待发货","待收货","已完成","退换货"]
        let images = ["yiwancheng","yiwancheng","yiwancheng","yiwancheng","yiwancheng"]

        var buttons: [ResizeSpacingButton] = []
        for (index, value) in titls.enumerated() {
            let button = ResizeSpacingButton(position: .Top, spacing: FitWidth(8))
            button.setTitle(value, for: .normal)
            button.setImage(UIImage(named: images[index]), for: .normal)
            button.setTitleColor(ImportantColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
            button.frame = CGRect(x: 0, y: 0, w: (SCREEN_WIDTH-FitWidth(44))/5, h: FitWidth(50))
            buttons.append(button)
        }
        
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing = 0
        return stack
    }()

}
