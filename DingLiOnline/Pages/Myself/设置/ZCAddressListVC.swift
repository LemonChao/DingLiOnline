//
//  ZCAddressListVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/3.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCAddressListVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(addButton)
        self.view.addSubview(tableView)
        if kiPhoneX {
            addButton.layer.cornerRadius = 22
            addButton.clipsToBounds = true
            addButton.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview().inset(FitWidth(15))
                make.height.equalTo(FitWidth(44))
                make.bottom.equalToSuperview().inset(IndicatorHomeHeight)
            }
        }else {
            addButton.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(FitWidth(44))
                make.bottom.equalToSuperview().inset(IndicatorHomeHeight)
            }
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(addButton.snp_top)
        }
        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "收货地址"
    }
    
    
    /// 重写button事件，拦截
    @objc func backButtonAction(_ button: UIButton) {
        if backCompleteEnclosure != nil {
            backCompleteEnclosure!("超哥的朋友圈")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonAction(_ button: UIButton) {
        let addVC = ZCAddressAddVC()
        
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    
    /// vc返回时闭包回调传值
    public var backCompleteEnclosure: ((_ string: String) -> Void)?
    let addButton = UIButton(title: "+添加地址", titleColor: UIColor.white, font: UIFont.systemFont(ofSize: FontSize(18)), bgColor: GeneralRedColor, target: self, action: #selector(addButtonAction(_:)))
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.register(ZCAddressListCell.self, forCellReuseIdentifier: "ZCAddressListCell_id")
        return table
    }()
}

extension ZCAddressListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCAddressListCell_id") as! ZCAddressListCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FitWidth(100)
    }
}

extension ZCAddressListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if backCompleteEnclosure != nil {
            backCompleteEnclosure!("超哥的朋友圈")
        }
        self.navigationController?.popViewController(animated: true)
    }
        
}
