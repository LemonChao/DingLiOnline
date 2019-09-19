//
//  ZCMyCardViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/11.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMyCardViewController: ZCBaseViewController {
    
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
        customNavBar.title = "银行卡"
        customNavBar.setRightButton(withTitle: "+", color: ImportantColor)
    }

    @objc func rightButtonAction(_ button: UIButton) {
        self.navigationController?.pushViewController(ZCMyBindCardViewController(), animated: true)
    }
    
    
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.rowHeight = FitWidth(144)
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(ZCMyCardTableCell.self, forCellReuseIdentifier: "ZCMyCardTableCell_id")
        return table
    }()

}

extension ZCMyCardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCMyCardTableCell_id") as! ZCMyCardTableCell
        
        return cell
    }
    
    
}
