//
//  ZCMyBanlanceWithdrawRecordVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyBanlanceWithdrawRecordVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(customNavBar.snp_bottom)
        }
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "提现到银行卡记录"
    }

    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.rowHeight = FitWidth(54)
        table.separatorInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        table.separatorColor = HexColor("0xf5f5f5")
        table.delegate = self
        table.dataSource = self
        return table
    }()

}

extension ZCMyBanlanceWithdrawRecordVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UItableViewCell_value1")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "UItableViewCell_value1")
            cell?.selectionStyle = .none
            cell?.textLabel?.textColor = PrimaryColor
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: FontSize(18))
            cell?.detailTextLabel?.textColor = TertiaryColor
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: FontSize(14))
            
            cell?.textLabel?.text = "-88"
            cell?.detailTextLabel?.text = "2019-07-25 16:36"
        }
        
        return cell!
    }
    
}
