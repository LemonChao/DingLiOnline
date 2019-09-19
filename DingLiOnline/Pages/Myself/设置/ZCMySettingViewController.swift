//
//  ZCMySettingViewController.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/12.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCMySettingViewController: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configCustomNav() {
        view.addSubview(customNavBar)
        customNavBar.title = "设置"
    }
    
    override func configViews() {
        view.backgroundColor = ScrollViewBackGroundColor
        view.addSubview(tableView)
    }
    
    @objc func quitButtonAction(_ button: UIButton) {
        
    }
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: NavBarHeight, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight))
        table.backgroundColor = UIColor.clear
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.alwaysBounceVertical = false
        table.separatorInset = UIEdgeInsets(top: 0, left: FitWidth(12), bottom: 0, right: FitWidth(12))
        table.separatorColor = HexColor("0xe5e5e5")
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(8)))
        let quitButton = UIButton(title: "退出登陆", titleColor: PrimaryColor, font: UIFont.systemFont(ofSize: FontSize(15)), bgColor: UIColor.white, target: self, action: #selector(quitButtonAction(_:)))
        quitButton.frame = CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(49))
        table.tableFooterView = quitButton
        table.register(ZCMySettingTableCell.self, forCellReuseIdentifier: "ZCMySettingTableCell_id")
        table.register(ZCMySettingAvatarCell.self, forCellReuseIdentifier: "ZCMySettingAvatarCell_id")
        return table
    }()
    
    let dataArray:[[[String:String]]] = [[["text":"头像","detailText":""],["text":"昵称","detailText":"Action"],["text":"手机号","detailText":"15378769701"],["text":"重置交易密码","detailText":""],["text":"收货地址","detailText":""]],
                                         [["text":"实名认证","detailText":"未实名"]],
                                         [["text":"关于我们","detailText":""]]]
    
}


extension ZCMySettingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataArray[section]
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let array = dataArray[indexPath.section]
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZCMySettingAvatarCell_id") as! ZCMySettingAvatarCell
            cell.dictionary = array[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ZCMySettingTableCell_id") as! ZCMySettingTableCell
            cell.dictionary = array[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return FitWidth(90)
        }else {
            return FitWidth(49)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return FitWidth(8)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dic = dataArray[indexPath.section][indexPath.row]
        
        switch dic["text"] {
        case "头像":
            self.navigationController?.pushViewController(ZCMySettingAvatarVC(), animated: true)
        case "昵称":
            self.navigationController?.pushViewController(ZCMySettingNicknameVC(), animated: true)
        case "手机号":
            self.navigationController?.pushViewController(ZCMySettingAvatarVC(), animated: true)
        case "重置登陆密码":
            self.navigationController?.pushViewController(ZCMySettingAvatarVC(), animated: true)
        case "重置交易密码":
            self.navigationController?.pushViewController(ZCSettingVerifyPhoneVC(), animated: true)
        case "收货地址":
            self.navigationController?.pushViewController(ZCAddressListVC(), animated: true)
        case "实名认证":
            self.navigationController?.pushViewController(ZCMySettingCertificationVC(), animated: true)
        case "关于我们":
            self.navigationController?.pushViewController(ZCMySettingAboutusVC(), animated: true)
        default:
            break
        }
        
        
    }
    
    
    
}
