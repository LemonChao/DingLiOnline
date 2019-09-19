//
//  ZCPaymentManagerView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/5.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

/// 支付管理类
class ZCPaymentManagerView: ZCBaseView {

    class func showPayment() {
        let payView = ZCPaymentManagerView(frame: UIScreen.main.bounds)
        
        UIApplication.shared.keyWindow?.addSubview(payView)
        
        payView.showAnimate()
        
    }
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGBA(0, 0, 0, 0)
        self.addSubview(scrollView)
        scrollView.addSubview(setupPayInfoView())
        scrollView.addSubview(setupPasswordView())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showAnimate() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = RGBA(0, 0, 0, 0.3)
            self.scrollView.frame = CGRect(x: 0, y: SCREEN_HEIGHT-self.scrollH, width: SCREEN_WIDTH, height: self.scrollH)
        }
    }
    
    func setupPayInfoView() -> UIView {
        let infoView = UIView(color: UIColor.white)
        infoView.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: scrollH)
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)

        let titleLab = UILabel(text: "付款详情", textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(18)))
        let line = UIView(color: LineColor)

        let payButton = UIButton(title: "确认支付", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, radius: FitWidth(22), target: self, action: #selector(payButtonAction(_:)))
        let attString = NSMutableAttributedString.colorfully(full: ["100.00元" : [.foregroundColor : ImportantColor, .font: UIFont.systemFont(ofSize: FontSize(28), weight: .medium)]], specials: ["元" : [NSAttributedString.Key.font : UIFont.systemFont(ofSize: FontSize(13))]])
        priceLabel.attributedText = attString
        
        
        
        infoView.addSubview(titleLab)
        infoView.addSubview(closeButton)
        infoView.addSubview(line)
        infoView.addSubview(priceLabel)
        infoView.addSubview(tableView)
        infoView.addSubview(payButton)

        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(infoView)
            make.top.equalToSuperview().inset(FitWidth(26))
        }
        closeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(15))
            make.centerY.equalTo(titleLab).offset(FitWidth(-4))
        }

        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(titleLab.snp_bottom).offset(FitWidth(14))
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp_bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(70))
        }

        payButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.height.equalTo(FitWidth(44))
            make.bottom.equalToSuperview().inset(FitWidth(10)+IndicatorHomeHeight)
        }

        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(priceLabel.snp_bottom)
            make.bottom.equalTo(payButton.snp_top).inset(-10)
        }
        
        return infoView
    }
    
    func setupPasswordView() -> UIView{
        let psView = UIView(color: UIColor.white)
        psView.frame = CGRect(x: SCREEN_WIDTH, y: 0, w: SCREEN_WIDTH, h: scrollH)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_black"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        let titleLab = UILabel(text: "请输入交易密码", textColor: ImportantColor, font: UIFont.systemFont(ofSize: FontSize(18)))
        let line = UIView(color: LineColor)
        let findButton = UIButton(title: "忘记密码？找回并完成支付", titleColor: AssistBlue, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: UIColor.white, target: self, action: #selector(findButtonAction(_:)))


        psView.addSubview(backButton)
        psView.addSubview(titleLab)
        psView.addSubview(line)
        psView.addSubview(passwordView)
        psView.addSubview(findButton)


        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(psView)
            make.top.equalToSuperview().inset(FitWidth(26))
        }
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(FitWidth(6))
            make.centerY.equalTo(titleLab)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(titleLab.snp_bottom).offset(FitWidth(14))
        }
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp_bottom).offset(FitWidth(25))
            make.left.right.equalToSuperview().inset(FitWidth(12))
            make.size.equalTo(CGSize(width: FitWidth(348), height: FitWidth(49)))
        }
        findButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp_bottom).offset(FitWidth(23))
            make.centerX.equalToSuperview()
        }
        
        return psView
    }
    
    
    @objc func payButtonAction(_ button: UIButton) {
        scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: true)
        passwordView.becomeFirstResponder()
    }
    
    @objc func backButtonAction(_ button: UIButton) {
        passwordView.resignFirstResponder()
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func findButtonAction(_ button: UIButton) {
        
    }

    @objc func closeButtonAction(_ button: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = RGBA(0, 0, 0, 0)
            self.scrollView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: self.scrollH)
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.register(ZCPaymentCell.self, forCellReuseIdentifier: "ZCPaymentCell_id")
        return table
    }()
    let scrollH = FitWidth(465)+IndicatorHomeHeight
    let priceLabel = UILabel(textColor: ImportantColor, font: UIFont.systemFont(ofSize: 12), aligment: NSTextAlignment.center)
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: SCREEN_HEIGHT, w: SCREEN_WIDTH, h: scrollH))
        scroll.contentSize = CGSize(width: SCREEN_WIDTH*2, height: scrollH)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        scroll.isScrollEnabled = false
        return scroll
    }()
    
    lazy var passwordView: ZCPasswordView = {
        let password = ZCPasswordView()
        password.rectangleH = FitWidth(49)
        password.rectangleW = FitWidth(58)
        password.boardColor = HexColor("0xcccccc")
        password.pointColor = PrimaryColor
        password.boardRadius = FitWidth(5)
        password.delegate = self
        return password
    }()
    
}

extension ZCPaymentManagerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCPaymentCell_id") as! ZCPaymentCell
        cell.button.setTitle("支付宝", for: .normal)
        cell.button.setImage(UIImage(named: "pay_zhifubao"), for: .normal)
        cell.button.imagePosition(.Left, spacing: FitWidth(10))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FitWidth(50)
    }
    
}

extension ZCPaymentManagerView: UITableViewDelegate {
    
    
    
}

extension ZCPaymentManagerView: ZCPasswordViewDelegate {
    func passWordBeginInput(_ passwordView: ZCPasswordView) {
        passwordView.resignFirstResponder()
    }
    
    
    func passWordCompleteInput(_ passwordView: ZCPasswordView) {
        passwordView.resignFirstResponder()
    }
    
}



class ZCPaymentCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        button.isSelected = selected
    }
    
    lazy var button: ResizeSpacingButton = {
        let btn = ResizeSpacingButton(position: .Left, spacing: FitWidth(10))
        btn.setTitleColor(PrimaryColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
        btn.isUserInteractionEnabled = false
        
        btn.setBackgroundColor(UIColor.clear, forState: .normal)
        btn.setBackgroundColor(RGBA(252,94,98,0.2), forState: .selected)
        return btn
    }()
}


