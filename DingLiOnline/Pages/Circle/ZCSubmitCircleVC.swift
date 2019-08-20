//
//  ZCSubmitCircleVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/13.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSubmitCircleVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom).offset(FitWidth(10))
            make.left.equalToSuperview().inset(FitWidth(12))
            make.right.equalToSuperview().inset(FitWidth(20))
            make.height.equalTo(FitWidth(120))
        }
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "创建圈子"
        customNavBar.setRightButton(withTitle: "发布", color: GeneralRedColor)
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
        
//        let image = UIImage(named: "IMG_3254.jpg")
        
//        QiniuTools.sharedInstance.uploadImageData(image: (image?.pngData())!) { (progress, imageKey) in
//            print("progress:\(String(describing: progress))  key:\(imageKey)")
//        }
        

    }
    
    
    lazy var textView: YYTextView = {
        let view = YYTextView()
        view.placeholderText = "写一下你想说的话吧~字数要在600字以内哟"
        view.placeholderTextColor = AssistColor
        view.placeholderFont = UIFont.systemFont(ofSize: FontSize(15))
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        view.typingAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize(15)), NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.kern:1]
        view.delegate = self
        return view
    }()
    
    
    
}

extension ZCSubmitCircleVC: YYTextViewDelegate {
    

    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let fullString: String = textView.text + text
        if fullString.count <= 60 || text == ""{
            return true
        }else {
            textView.text = String(fullString.prefix(60))
            return false
        }
    }
    
}

