//
//  ZCFocusViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCFocusViewController: ZCBaseViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.view.addSubview(tableView)
        
        NetworkHelper.postRequestWith(url: kcircleList, params: ["condition": "1","pn":"1","num":"10"], success: { (respons) in
            let data = ZCFocusDataModel(jsonData: respons["data"])
            self.dataArray = data.list
            self.tableView.reloadData()
        }) { (error) in
            
        }
        
        
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight-TabBarHeight), style: .plain)
        view.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.dataSource = self
        view.delegate = self
        view.register(ZCFocusTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(ZCFocusTableViewCell.self))
        view.tableFooterView = UIView()
        view.estimatedRowHeight = 500
        return view
    }()
    
    var dataArray: [ZCFocusListModel] = []
    

}

extension ZCFocusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCFocusTableViewCell.self)) as! ZCFocusTableViewCell        
        cell.model = dataArray[indexPath.row]
        return cell
        
    }
    
    
}

extension ZCFocusViewController: UITableViewDelegate {
    
}


