//
//  ZCPayMarginVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/26.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

/// 缴纳保证金
class ZCPayMarginVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LineColor
        self.setupUI()
        
        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "报名提交保证金"
        
    }

    func setupUI() {
        let payButton = UIButton(type: .custom)
        payButton.setTitle("报名，提交保证金", for: .normal)
        payButton.backgroundColor = GeneralRedColor
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(18))
        payButton.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
//        payButton.titleEdgeInsets = UIEdgeInsets(top: -IndicatorHomeHeight/2, left: 0, bottom: IndicatorHomeHeight/2, right: 0)
        
        self.view.addSubview(payButton)
        self.view.addSubview(marginBG)
        self.view.addSubview(adviceView)
        self.view.addSubview(addressView)
        self.view.addSubview(xieyiView)
        addressView.addSubview(addressInfoView)
        
        payButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(49))
            make.bottom.equalToSuperview().inset(IndicatorHomeHeight)
        }
        
        marginBG.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom)
            make.left.right.equalToSuperview()
        }
        
        adviceView.snp.makeConstraints { (make) in
            make.top.equalTo(marginBG.snp_bottom).offset(FitWidth(8))
            make.left.right.equalToSuperview()
        }
        
        addressView.snp.makeConstraints { (make) in
            make.top.equalTo(adviceView.snp_bottom).offset(FitWidth(8))
            make.left.right.equalToSuperview()
        }
        
        xieyiView.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp_bottom).offset(FitWidth(8))
            make.left.right.equalToSuperview()
            make.bottom.equalTo(payButton.snp_top)
        }
        
    }
    
    @objc func payButtonAction(_ button: UIButton) {
        
    }
    
    @objc func xieyiButtonAction(_ button: UIButton) {
        
    }
    
    /// 添加收货地址
    @objc func addAddressButtonAction(_ button: UIButton) {
        let vc = ZCAddressListVC()
        vc.backCompleteEnclosure = {(name: String) in
            self.addressInfoView.isHidden = name.isEmpty
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func addressMoreButtonAction(_ button: UIButton) {
        let vc = ZCAddressListVC()
        vc.backCompleteEnclosure = {(name: String) in
            self.addressInfoView.isHidden = name.isEmpty
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var marginBG: UIView = {
        let view = UIView(color: MinorColor)
        
        let baozhengLab = UILabel(text: "保证金", textColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(17)))
        let priceLab = UILabel()
        priceLab.attributedText = NSMutableAttributedString.colorfully(full: ["￥100":[NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: FontSize(38))]], specials: ["￥": [NSAttributedString.Key.font:UIFont.systemFont(ofSize: FontSize(13))]])
        let lineView = UIView(color: UIColor.white)
        let noteButton = ResizeSpacingButton(position: .Left, spacing: FitWidth(13))
        noteButton.setImage(UIImage(named: "margin_note_white"), for: .normal)
        noteButton.setTitle("竞拍不成功时，保证金将原路退回", for: .normal)
        noteButton.setTitleColor(UIColor.white, for: .normal)
        noteButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        
        view.addSubview(baozhengLab)
        view.addSubview(priceLab)
        view.addSubview(lineView)
        view.addSubview(noteButton)
        
        baozhengLab.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(FitWidth(20))
        })
        priceLab.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(baozhengLab.snp_bottom).offset(FitWidth(28))
        })
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(priceLab.snp_bottom).offset(FitWidth(20))
            make.height.equalTo(1)
        }
        noteButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(12))
            make.top.equalTo(lineView.snp_bottom).offset(FitWidth(20))
            make.bottom.equalToSuperview().inset(FitWidth(17))
            
        }
        
        noteButton.imagePosition(.Left, margin: 0)
        return view
    }()
    
    
    lazy var adviceView: UIView = {
        let view = UIView(color: UIColor.white)
        let string = """
                    该拍品需缴纳保证金100。
                    建议您使用余额、支付宝、微信、银行卡支付
                    要确保账户有足够的钱款哦
                    """
        
        let label = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = FitWidth(4)
        label.attributedText = NSMutableAttributedString.colorfully(full: [string: [.foregroundColor: PrimaryColor,.font: UIFont.systemFont(ofSize: FontSize(15)), .paragraphStyle: paragraph]], specials: ["余额、支付宝、微信、银行卡支付":[.foregroundColor: GeneralRedColor]])
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsets(top: FitWidth(15), left: FitWidth(12), bottom: FitWidth(15), right: FitWidth(12)))
        })
        return view
    }()
    
    lazy var addressView: UIView = {
        let view = UIView(color: UIColor.white)
        let addAddressButton = UIButton(type: .custom)
        addAddressButton.backgroundColor = HexColor("0xf5f5f5")
        addAddressButton.setTitle("+ 添加地址", for: .normal)
        addAddressButton.setTitleColor(PrimaryColor, for: .normal)
        addAddressButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(18))
        addAddressButton.addTarget(self, action: #selector(addAddressButtonAction(_:)), for: .touchUpInside)
        addAddressButton.layer.cornerRadius = FitWidth(25)
        addAddressButton.clipsToBounds = true
        
        let redLabel = UILabel(text: "为保证竞拍成功后拍品顺利送达，请确认您的收货地址", textColor: GeneralRedColor, font: UIFont.systemFont(ofSize: FontSize(12)))
        
        view.addSubview(addAddressButton)
        view.addSubview(redLabel)
        
        
        addAddressButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(FitWidth(20))
            make.size.equalTo(CGSize(width: FitWidth(250), height: FitWidth(50)))
        })
        redLabel.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().inset(FitWidth(90))
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.bottom.equalToSuperview().inset(FitWidth(10))
        })
        
        return view
    }()
    
    lazy var xieyiView: UIView = {
        let view = UIView(color: UIColor.white)
        let agreeButton = ResizeSpacingButton(position: .Left, spacing: FitWidth(10))
        agreeButton.setImage(UIImage(named: "check_select_red"), for: .normal)
        agreeButton.setImage(UIImage(named: "check_normal_black"), for: .selected)
        agreeButton.setTitle("竞拍需同意鼎力在线", for: .normal)
        agreeButton.setTitle("竞拍需同意鼎力在线", for: .selected)
        agreeButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        agreeButton.setTitleColor(PrimaryColor, for: .normal)
        agreeButton.setTitleColor(PrimaryColor, for: .selected)
        
        let xieyiButton = UIButton(type: .custom)
        xieyiButton.setTitle("竞拍协议", for: .normal)
        xieyiButton.setTitleColor(AssistBlue, for: .normal)
        xieyiButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(12))
        xieyiButton.addTarget(self, action: #selector(xieyiButtonAction(_:)), for:.touchUpInside)
        
        view.addSubview(agreeButton)
        view.addSubview(xieyiButton)
        
        agreeButton.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().inset(FitWidth(10))
            make.left.equalToSuperview().inset(FitWidth(12))
        })
        
        xieyiButton.snp.makeConstraints({ (make) in
            make.centerY.equalTo(agreeButton)
            make.left.equalTo(agreeButton.snp_right)
        })
        
        agreeButton.imagePosition(.Left, margin: 0)
        return view
    }()
    
    
    lazy var addressInfoView: UIView = {
        let view = UIView(color: UIColor.white)
        view.isHidden = true
        view.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(90))
        
        let receiver = UILabel(text: "收货人", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let nameLab = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let telLab = UILabel(textColor: TertiaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let addTitle = UILabel(text: "收货地址", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)))
        let addressLab = UILabel()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = FitWidth(4)
        addressLab.attributedText = NSAttributedString(string: "河南省郑州市管城回族区北下街 街道裕鸿国际A座703", attributes: [NSAttributedString.Key.foregroundColor: TertiaryColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize(15))])
        addressLab.numberOfLines = 2
        let addressMoreButton = UIButton(type: .custom)
        addressMoreButton.setImage(UIImage(named: "arrow_right_333"), for: .normal)
        addressMoreButton.setImage(UIImage(named: "arrow_right_333"), for: .selected)
        addressMoreButton.addTarget(self, action: #selector(addressMoreButtonAction(_:)), for: .touchUpInside)
        
        nameLab.text = "小可气的说法大发手动阀是的范德萨"
        telLab.text = "15515052147"
//        addressLab.text = "河南省郑州市管城回族区北下街 街道裕鸿国际A座703"
        
        view.addSubview(receiver)
        view.addSubview(nameLab)
        view.addSubview(telLab)
        view.addSubview(addTitle)
        view.addSubview(addressLab)
        view.addSubview(addressMoreButton)
        
        receiver.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().inset(FitWidth(15))
            make.left.equalToSuperview().inset(FitWidth(12))
        })
        
        telLab.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().inset(FitWidth(60))
            make.top.equalToSuperview().inset(FitWidth(15))
        })

        nameLab.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().inset(FitWidth(15))
            make.left.equalToSuperview().inset(FitWidth(106))
            make.right.lessThanOrEqualTo(telLab.snp_left).offset(FitWidth(-15))
        })
        
        addTitle.snp.makeConstraints({ (make) in
            make.top.equalTo(receiver.snp_bottom).offset(FitWidth(15))
            make.left.equalToSuperview().inset(FitWidth(12))
        })
        
        addressLab.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().inset(FitWidth(106))
            make.right.equalToSuperview().inset(FitWidth(60))
            make.top.equalTo(addTitle)
        })
        
        addressMoreButton.snp.makeConstraints({ (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(FitWidth(30))
            make.right.equalToSuperview().inset(FitWidth(3))
        })
        
        return view
    }()
    
}
