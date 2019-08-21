//
//  ZCSubmitBottomView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/20.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSubmitBottomView: UIView {

    
    init(frame:CGRect, items: [String:String]...) {
        super.init(frame: frame)
        self.backgroundColor = LineColor
        for (index,item) in items.enumerated() {
            
            var selector: Selector!
            
            if index == 0 {
                selector = #selector(cellHuatiButtonAction(_:))
            }else {
                selector = #selector(cellQuanxianButtonAction(_:))
            }
            
            let mainView = self.creatCell(imageName: item["imageName"]!, title: item["title"]!, selectTitle: item["selectTitle"]!, action: selector)
            let cellView = mainView.cell
            
            let button = mainView.button
            let leftButton = mainView.leftButton
            
            self.addSubview(cellView)
            let y = FitWidth(50) * CGFloat(index)
            
            cellView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().inset(y)
                make.left.right.equalToSuperview()
                make.height.equalTo(FitWidth(49))
            }
            self.layoutIfNeeded()
            leftButton.imagePosition(.Left, margin: 0)
            button.imagePosition(.Right, margin: 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func creatCell(imageName: String, title: String, selectTitle: String, action:Selector) -> (cell: UIView, button: UIButton, leftButton: UIButton) {
        let view = UIView(color: UIColor.white)
        
//        let leftButton = UIButton(type: .custom)
        let leftButton = ResizeSpacingButton(position: .Left, spacing: FitWidth(10))
        leftButton.setImage(UIImage(named: imageName), for: .normal)
        leftButton.setTitle(title, for: .normal)
        leftButton.setTitleColor(AssistBlue, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        leftButton.isUserInteractionEnabled = false

        let rightButton = ResizeSpacingButton(position: .Right, spacing: FitWidth(10))
        rightButton.setImage(UIImage(named: "circle_arrowRight_lightGray"), for: .normal)
        rightButton.setTitle(selectTitle, for: .normal)
        rightButton.setTitleColor(TertiaryColor, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        rightButton.addTarget(self.viewController, action: action, for: .touchUpInside)
        view.addSubview(leftButton)
        view.addSubview(rightButton)

        leftButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(FitWidth(12))
        }

        rightButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(FitWidth(12))
        }
        
//        let imgView = UIImageView(image: UIImage(named: imageName))
//        let titleLabel = UILabel(text: title, textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
//
        
        
        
        return (view, rightButton, leftButton)
    }
    
    @objc func cellHuatiButtonAction(_ button: ResizeSpacingButton) {
        
        if let vc = self.viewController() {
            if vc.responds(to: #selector(cellHuatiButtonAction(_:))) {
                vc.perform(#selector(cellHuatiButtonAction(_:)), with: button)
            }
        }
    }
    
    @objc func cellQuanxianButtonAction(_ button: ResizeSpacingButton) {
        
        if let vc = self.viewController() {
            if vc.responds(to: #selector(cellQuanxianButtonAction(_:))) {
                vc.perform(#selector(cellQuanxianButtonAction(_:)), with: button)
            }
        }
    }

    
}
