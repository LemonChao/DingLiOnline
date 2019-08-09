//
//  ZCClassifyViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

class ZCClassifyViewController: ZCBaseViewController {

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: NavBarHeight, w: FitWidth(84), h: SCREEN_HEIGHT-NavBarHeight-TabBarHeight), style: .plain)
        view.backgroundColor = ScrollViewBackGroundColor
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.delegate = self
        view.dataSource = self
        view.register(ZCClassifyLeftCell.self, forCellReuseIdentifier: NSStringFromClass(ZCClassifyLeftCell.self))
        return view
    }()
    
    let rightController = ZCClassifyRightController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        rightController.view.frame = CGRect(x: FitWidth(84), y: NavBarHeight, w: SCREEN_WIDTH-FitWidth(84), h: SCREEN_HEIGHT)
        self.addChild(rightController)
        self.view.addSubview(rightController.view)
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
    }

}


extension ZCClassifyViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ZCClassifyLeftCell.self)) as! ZCClassifyLeftCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FitWidth(60)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

