//
//  ZCGoodsDetailViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/22.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCGoodsDetailViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bottomView)
        self.view.addSubview(tableView)
        
        tableHeaderView.auctionState = ZCGoodsAuctionState.over
        tableFooterView.reloadPages()
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.setBackButton(withImage: UIImage(named: "back_white_round"))
        customNavBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        customNavBar.setBottomLine(hidden: true)
    }

    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-FitWidth(49)-IndicatorHomeHeight), style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = FitWidth(34)
        table.estimatedSectionFooterHeight = FitWidth(8)
        table.estimatedSectionHeaderHeight = FitWidth(44)
        table.tableHeaderView = tableHeaderView
        table.tableFooterView = tableFooterView
        table.backgroundColor = UIColor.red
        table.bounces = false
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        table.register(ZCGoodsAuctionRecordCell.self, forCellReuseIdentifier: "ZCGoodsAuctionRecordCell_id")
        table.register(ZCGoodDetailServiceHeader.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(ZCGoodDetailServiceHeader.self))
        table.register(ZCGoodDetailSectionFooter.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(ZCGoodDetailSectionFooter.self))
        table.register(ZCGoodsAuctionRecordHeader.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(ZCGoodsAuctionRecordHeader.self))
        table.register(ZCGoodsAuctionInfoHeader.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(ZCGoodsAuctionInfoHeader.self))
        table.register(ZCGoodsAuctionRecommendHeader.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(ZCGoodsAuctionRecommendHeader.self))
        return table
    }()
    
    
    
    let bottomView = ZCGoodsDetailBottomView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-FitWidth(49)-IndicatorHomeHeight, w: SCREEN_WIDTH, h: FitWidth(49)))
    let tableHeaderView = ZCGoodsDetailTableHeaderView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(485)))
    let tableFooterView = ZCGoodsDetailTableFooter(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight))
    
    
}
extension ZCGoodsDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ZCGoodsAuctionRecordCell_id")!
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodDetailServiceHeader.self))
            
        case 1:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodsAuctionRecordHeader.self))
            
        case 2:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodsAuctionInfoHeader.self))

        case 3:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodsAuctionRecommendHeader.self))

        default:
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodDetailServiceHeader.self))
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodDetailSectionFooter.self))
        footer?.contentView.backgroundColor = LineColor
        return footer
    }
    
}

extension ZCGoodsDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        if offsetY >= tableFooterView.y { //tableFooter 驻留
            scrollView.setContentOffset(CGPoint(x: 0, y: tableFooterView.y), animated: false)
        }
        
        
    }
    
    
    
    
}


