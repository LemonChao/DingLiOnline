//
//  ZCMyBalanceRecordVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/10.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyBalanceRecordVC: ZCBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavBar.snp_bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "余额记录"
        
    }
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.estimatedRowHeight = FitWidth(73)
        table.separatorInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        table.separatorColor = HexColor("0xf5f5f5")
        table.delegate = self
        table.dataSource = self
        table.register(ZCMyBalanceTableCell.self, forCellReuseIdentifier: "ZCMyBalanceTableCell_id")
        return table
    }()

}

extension ZCMyBalanceRecordVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCMyBalanceTableCell_id") as! ZCMyBalanceTableCell
        return cell
    }

}
