//
//  ZCGoodsNoteVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/24.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
/*
 Descript viewWillAppear ++
 goods viewWillAppear ++
 D->N
 Note viewWillAppear ++
 Descript viewWillDisappear --

 */
/// 拍品须知
class ZCGoodsNoteVC: ZCBaseViewController {

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("Note viewWillAppear ++")
//    }
//    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        print("Note viewWillDisappear --")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentView = UIView()
        let liuchengLab = UILabel(text: "竞买流程", textColor: PrimaryColor, font: UIFont.boldSystemFont(ofSize: FontSize(15)))
        let liuchengLine = UIView(color: LineColor)
        let buyImgView = UIImageView(contentMode: .scaleAspectFit, image: UIImage(named: "jingmailiucheng"))

        let baozhengLab = UILabel(text: "保证金须知", textColor: PrimaryColor, font: UIFont.boldSystemFont(ofSize: FontSize(15)))
        let baozhengLine = UIView(color: LineColor)

        let liuchengBtn = redLineButton(title: "保证金流程")
        let liuchengImgView = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "baozhengliucheng"))
        let shifangBtn = redLineButton(title: "保证金释放")
        
        let shifangString =  """
        1.竞拍成功后，买家需先支付所成交产品的货款，然 后保证金将在3-5个工作日内释放

        2.产品未竞拍成功（出局），待拍卖结束后，保证金 将在3-5个工作日内释放
        """
        let shifangLab = UILabel(text: shifangString, textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        shifangLab.numberOfLines = 0
        let kouchuBtn = redLineButton(title: "保证金扣除")
        let kouchuLab = UILabel(text: "1.凡是竞拍成功的买家，在竞拍结束后24小时内未付 货款，系统会自动关闭交易，扣除保证金。", textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        kouchuLab.numberOfLines = 0
        let copyRightImgView = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "techSupport"))
        
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(liuchengLab)
        contentView.addSubview(liuchengLine)
        contentView.addSubview(buyImgView)
        contentView.addSubview(baozhengLab)
        contentView.addSubview(baozhengLine)
        contentView.addSubview(liuchengBtn)
        contentView.addSubview(liuchengImgView)
        contentView.addSubview(shifangBtn)
        contentView.addSubview(shifangLab)
        contentView.addSubview(kouchuBtn)
        contentView.addSubview(kouchuLab)
        contentView.addSubview(copyRightImgView)
        
        let margin:CGFloat = 12
        
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        liuchengLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(margin)
            make.top.equalToSuperview().inset(FitWidth(15))
        }
        liuchengLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(liuchengLab.snp_bottom).offset(FitWidth(15))
            make.height.equalTo(1)
        }
        buyImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(liuchengLine).offset(FitWidth(15))
//            make.left.right.equalToSuperview().inset(FitWidth(12))
        }
        baozhengLab.snp.makeConstraints { (make) in
            make.top.equalTo(buyImgView.snp_bottom).offset(FitWidth(15))
            make.left.equalToSuperview().inset(FitWidth(margin))
        }
        baozhengLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(baozhengLab.snp_bottom).offset(FitWidth(15))
            make.height.equalTo(1)
        }
        liuchengBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(margin)
            make.top.equalTo(baozhengLine.snp_bottom).offset(FitWidth(15))
        }
        liuchengImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(liuchengBtn.snp_bottom).offset(FitWidth(15))
        }
        shifangBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(margin))
            make.top.equalTo(liuchengImgView.snp_bottom).offset(FitWidth(15))
        }
        shifangLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(margin))
            make.top.equalTo(shifangBtn.snp_bottom).offset(FitWidth(15))
        }
        kouchuBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(margin))
            make.top.equalTo(shifangLab.snp_bottom).offset(FitWidth(15))
        }
        kouchuLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(margin))
            make.top.equalTo(kouchuBtn.snp_bottom).offset(FitWidth(15))
        }
        copyRightImgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(kouchuLab.snp_bottom).offset(FitWidth(15))
        }

        contentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(copyRightImgView.snp_bottom)
        }
        
        liuchengBtn.imagePosition(.Left, margin: 0)
        shifangBtn.imagePosition(.Left, margin: 0)
        kouchuBtn.imagePosition(.Left, margin: 0)
        
    }
    
    func redLineButton(title: String) -> ResizeSpacingButton {
        let button = ResizeSpacingButton(position: .Left, spacing: 3)
        
        button.setImage(UIImage(color: GeneralRedColor, size: CGSize(width: 2, height: 12)), for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(PrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        button.isUserInteractionEnabled = false
        return button
    }
    
    
    
    lazy var scrollView: ZCSimultaneouslyScrollView = {
        let view = ZCSimultaneouslyScrollView(frame: CGRect.zero)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

        return view
    }()
    
    
    var noteScoll = true
    // 代理
    weak var delegate: ZCGoodsViewWillEndDraggingDelegate?

}


extension ZCGoodsNoteVC: UIScrollViewDelegate {
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.goodsWillEndDragging(scrollView)
    }
    
    
}

