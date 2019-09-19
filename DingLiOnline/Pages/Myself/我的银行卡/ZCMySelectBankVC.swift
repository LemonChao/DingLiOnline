//
//  ZCMySelectBankVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/11.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySelectBankVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
    }
    
    
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.setBackButton(withImage: UIImage(named: "close"))
        customNavBar.title = "选择银行卡名称"
    }
    
    /// 重写button事件，拦截
    @objc func backButtonAction(_ button: UIButton) {
        if backCompleteEnclosure != nil {
            backCompleteEnclosure!("超哥的朋友圈")
        }
        self.goBack()
    }
    
    /// vc返回时闭包回调传值
    public var backCompleteEnclosure: ((_ string: String) -> Void)?
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: NavBarHeight, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight), style: .plain)
        table.rowHeight = FitWidth(36)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.contentInset = UIEdgeInsets(top: FitWidth(9), left: 0, bottom: 0, right: 0)
        return table
    }()
    
    

}

extension ZCMySelectBankVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell_default")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell_default")
            cell?.imageView?.image = UIImage(named: "ICBC")
            cell?.textLabel?.text = "中国邮政储蓄银行"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: FontSize(15))
            cell?.textLabel?.textColor = PrimaryColor
        }
        
        return cell!
    }
    
    
    
    
    
}
