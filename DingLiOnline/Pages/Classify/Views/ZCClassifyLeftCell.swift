//
//  ZCClassifyLeftCell.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/2.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCClassifyLeftCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
