//
//  ZCMyselfViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZCMyselfViewController: ZCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.setBackButton(withImage: UIImage())
        customNavBar.rightButton.setImage(UIImage(named: "shezhi"), for: .normal)
        customNavBar.backgroundColor = UIColor.white.withAlphaComponent(0)
        customNavBar.bottomLine.backgroundColor = LineColor.withAlphaComponent(0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if changeDefault {
            return UIStatusBarStyle.default
        }
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkHelper.postRequestWith(url: kuserInfo, params: nil, success: { (response) in
            if response["result"].intValue == 1 {
                self.userInfo = response["data"].dictionaryValue
                (self.tableView.tableHeaderView as! ZCMyselfTableHeaderView).userInfo = self.userInfo
            }

        })
    }
    
    
    @objc func rightButtonAction(_ button: UIButton) {
        let naviVC = ZCBaseNavigationController.init(rootViewController: ZCLoginViewController())
        self.present(naviVC, animated: true) {
            
        }
        
        
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-TabBarHeight), style: .plain)
        view.delegate = self
        view.dataSource = self
        let header = ZCMyselfTableHeaderView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(253)+StatusBarHeight))
        view.tableHeaderView = header
        view.backgroundColor = ScrollViewBackGroundColor
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.estimatedRowHeight = 200
        view.register(ZCMyselfOrderCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfOrderCell.self))
        view.register(ZCMyselfAssetsCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfAssetsCell.self))
        view.register(ZCMyselfPromotionCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfPromotionCell.self))
        view.register(ZCMyselfFeedbackCell.self, forCellReuseIdentifier: NSStringFromClass(ZCMyselfFeedbackCell.self))

        return view
    }()
    
    
    var userInfo:[String:JSON]!      // 用户信息
    let colorChangePoint = FitWidth(200)-NavBarHeight*2
    var changeDefault = false //状态栏变为default style
    
    
}

extension ZCMyselfViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfFeedbackCell.self)) as! ZCMyselfFeedbackCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCMyselfFeedbackCell.self)) as! ZCMyselfFeedbackCell
            return cell
        }
    }
}


extension ZCMyselfViewController: UITableViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        let needUpdate: Bool = offsetY > (colorChangePoint + NavBarHeight/2)
        if needUpdate != changeDefault { /// 减少刷新频率，需要时再刷新
            changeDefault = needUpdate
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        
        if offsetY < colorChangePoint || offsetY == 0 {
            customNavBar.backgroundColor = UIColor.white.withAlphaComponent(0)
            customNavBar.title = ""
        }else {
            let alpha = (offsetY - colorChangePoint) / NavBarHeight;
            customNavBar.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            customNavBar.bottomLine.backgroundColor = LineColor.withAlphaComponent(alpha)
            customNavBar.title = "我的"
        }
    }
}

