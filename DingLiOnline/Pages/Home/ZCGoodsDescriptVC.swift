//
//  ZCGoodsDescriptVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/24.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

/// 拍品详情-拍品描述
class ZCGoodsDescriptVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        print("Descript viewWillDisappear --")
    }

    // 代理
    weak var delegate: ZCGoodsViewWillEndDraggingDelegate?
    lazy var tableView: ZCSimultaneouslyTableView = {
        let table = ZCSimultaneouslyTableView(frame: CGRect.zero, style: .grouped)
        
        table.estimatedSectionHeaderHeight = FitWidth(34)
        table.estimatedRowHeight = FitWidth(30)
        table.estimatedSectionFooterHeight = 0
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        let copyRightImgView = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "techSupport"))
        table.tableFooterView = copyRightImgView
        
        table.backgroundColor = ScrollViewBackGroundColor
        table.register(ZCGoodsDescriptPropertyCell.self, forCellReuseIdentifier: NSStringFromClass(ZCGoodsDescriptPropertyCell.self))
        table.register(ZCGoodsDescriptImageCell.self, forCellReuseIdentifier: NSStringFromClass(ZCGoodsDescriptImageCell.self))
        table.register(ZCGoodsDescriptSectionHeader.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(ZCGoodsDescriptSectionHeader.self))
        return table
    }()
    
    
}

extension ZCGoodsDescriptVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCGoodsDescriptPropertyCell.self)) as! ZCGoodsDescriptPropertyCell
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCGoodsDescriptImageCell.self)) as! ZCGoodsDescriptImageCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(ZCGoodsDescriptSectionHeader.self))
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.goodsWillEndDragging(scrollView)
    }

}

