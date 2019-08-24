//
//  ZCSimultaneouslyScrollView.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/24.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSimultaneouslyScrollView: UIScrollView {


}

extension ZCSimultaneouslyScrollView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
