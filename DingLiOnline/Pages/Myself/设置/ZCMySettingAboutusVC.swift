//
//  ZCMySettingAboutusVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/17.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingAboutusVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
    }
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "关于我们"
    }
    
    func creatTableHeader() -> UIView {
        let view = UIView(color: UIColor.white)
        view.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(200))
        let logo = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "avatar_default"))
        let versionLab = UILabel(text: "V1.0.0版本", textColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(14)))
        let bottomLine = UIView(color: ScrollViewBackGroundColor)
        
        view.addSubview(logo)
        view.addSubview(versionLab)
        view.addSubview(bottomLine)
        
        logo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(FitWidth(60))
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: FitWidth(64), height: FitWidth(64)))
        }
        versionLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logo.snp_bottom).offset(FitWidth(10))
        }
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
        return view
    }
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: NavBarHeight, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight), style: .plain)
        table.rowHeight = FitWidth(53)
        table.dataSource = self
        table.delegate = self
        table.alwaysBounceVertical = false
        table.separatorColor = ScrollViewBackGroundColor
        table.tableHeaderView = creatTableHeader()
        table.tableFooterView = UIView()
        table.separatorInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        table.register(ZCMySettingImprintCell.self, forCellReuseIdentifier: "ZCMySettingImprintCell_id")
        return table
    }()
    
    let dataArray: [[String:String]] = [["text":"版本更新","detailText":"yishiyishi"],["text":"版本说明","detailText":""],["text":"服务协议","detailText":""],["text":"营业执照","detailText":""]]
    
}

extension ZCMySettingAboutusVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZCMySettingImprintCell_id") as! ZCMySettingImprintCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(ZCMySettingUpdatesVC(), animated: true)
        case 1:
            self.navigationController?.pushViewController(ZCMySettingImprintVC(), animated: true)
        case 2:
            self.navigationController?.pushViewController(ZCMySettingServiceAgreementVC(), animated: true)
        case 3:
            self.navigationController?.pushViewController(ZCMySettingBusinessLicenseVC(), animated: true)
        default:
            break
        }
    }
    
}



