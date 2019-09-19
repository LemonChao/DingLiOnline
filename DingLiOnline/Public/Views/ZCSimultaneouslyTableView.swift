//
//  ZCSimultaneouslyTableView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/24.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSimultaneouslyTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ZCSimultaneouslyTableView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

