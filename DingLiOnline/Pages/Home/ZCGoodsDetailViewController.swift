//
//  ZCGoodsDetailViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/22.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

protocol ZCGoodsViewWillEndDraggingDelegate: class {
    func goodsWillEndDragging(_ scrollView: UIScrollView)
}


class ZCGoodsDetailViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bottomView)
        self.view.addSubview(tableView)
        
        tableHeaderView.auctionState = ZCGoodsAuctionState.over
//        tableFooterView.reloadPages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("goods viewWillAppear ++")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("goods viewWillDisappear --")
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
        
        table.tableFooterView = footerView
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
    
//    func tableFooter() -> (footer: UIView, pageVC: ZCPageController) {
//        let footer = UIView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight))
//        let topHolderView = UIView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: NavBarHeight-FitWidth(40)))
//
//        let vc = ZCPageController(titles: ["拍品描述","竞拍须知"], vcs: [descriptVC,noteVC], pageStyle: .topTabBar)
//        vc.view.frame = CGRect(x: 0, y: topHolderView.bounds.height, w: SCREEN_WIDTH, h:footer.bounds.height - topHolderView.bounds.height)
//        self.addChild(vc)
//        footer.addSubview(topHolderView)
//        footer.addSubview(vc.view)
//
//        return (footer, vc)
//    }
    
    let bottomView = ZCGoodsDetailBottomView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-FitWidth(49)-IndicatorHomeHeight, w: SCREEN_WIDTH, h: FitWidth(49)))
    let tableHeaderView = ZCGoodsDetailTableHeaderView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(485)))
    
    lazy var footerView: UIView = {
        let footer = UIView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight))
        footer.backgroundColor = UIColor.white
        let topHolderView = UIView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: NavBarHeight-FitWidth(40)))
        
        let vc = ZCPageController(titles: ["拍品描述","竞拍须知"], vcs: [descriptVC,noteVC], pageStyle: .topTabBar)
        vc.view.frame = CGRect(x: 0, y: topHolderView.bounds.height, w: SCREEN_WIDTH, h:footer.bounds.height - topHolderView.bounds.height)
        self.addChild(vc)
        footer.addSubview(topHolderView)
        footer.addSubview(vc.view)

        return footer
    }()
    
    lazy var descriptVC:ZCBaseViewController = {
        let vc = ZCGoodsDescriptVC()
        vc.delegate = self
        return vc
    }()
    lazy var noteVC:ZCBaseViewController = {
        let vc = ZCGoodsNoteVC()
        vc.delegate = self
        return vc
    }()
//    lazy var footerPageVC: ZCPageController = {
//        let pageVC = ZCPageController(titles: ["拍品描述","竞拍须知"], vcs: [descriptVC,noteVC], pageStyle: .topTabBar)
//        return pageVC
//    }()
    
    var goodsScroll = true
    
    
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
        
        /// 当 底层滚动式图滚动到指定位置时， 停止滚动，开始滚动子视图

        let offsetY = scrollView.contentOffset.y
        if offsetY >= footerView.y || !goodsScroll{ //tableFooter 驻留
            scrollView.setContentOffset(CGPoint(x: 0, y: footerView.y), animated: false)
            goodsScroll = false

        }

        
    }
    
    
    
    
}

extension ZCGoodsDetailViewController: ZCGoodsViewWillEndDraggingDelegate {
    
    func goodsWillEndDragging(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset ,footerView.y)

        if scrollView.contentOffset.y < 0 {// parent 滑动
            goodsScroll = true
        }
        if goodsScroll {
            scrollView.setContentOffset(CGPoint.zero, animated: false)
        }
        
        
    }
    
}
