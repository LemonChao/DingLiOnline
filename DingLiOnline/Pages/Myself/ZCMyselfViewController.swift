//
//  ZCMyselfViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCMyselfViewController: ZCBaseViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight), style: .plain)
        view.delegate = self
        view.dataSource = self
        let header = ZCMyselfTableHeaderView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(253)+StatusBarHeight))
        view.tableHeaderView = header
        view.backgroundColor = ScrollViewBackGroundColor
        view.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.estimatedRowHeight = 200
        view.register(ZCMyselfOrderCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfOrderCell.self))
        view.register(ZCMyselfAssetsCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfAssetsCell.self))
        view.register(ZCMyselfPromotionCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfPromotionCell.self))
        view.register(ZCMyselfFeedbackCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfFeedbackCell.self))

        return view
    }()
    
}

extension ZCMyselfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfOrderCell.self)) as! ZCMyselfOrderCell
            cell.model = ""
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfAssetsCell.self)) as! ZCMyselfAssetsCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfPromotionCell.self)) as! ZCMyselfPromotionCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfFeedbackCell.self)) as! ZCMyselfFeedbackCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfFeedbackCell.self)) as! ZCMyselfFeedbackCell
            return cell
        }
    
    }
}


extension ZCMyselfViewController: UITableViewDelegate {
    
}


