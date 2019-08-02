//
//  AppColorHeader.swift
//  DingLiOnline
//
//  Created by zchao on 2019/7/26.
//  Copyright © 2019 zchao. All rights reserved.
//

import UIKit

//颜色
func RGBA(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat) -> UIColor {
    return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
}

func HexColor(_ HexString: String) ->UIColor {
    return UIColor.colorWith(hexString: HexString)
}

/** 背景 - ffffff */
let BackGroundColor = RGBA(255, 255, 255, 1)

let ScrollViewBackGroundColor = RGBA(244, 243, 243, 1)


/** 线条 - e5e5e5 */
let LineColor = RGBA(229, 229, 229, 1)


/** 重要 - 0C0B0B */
let ImportantColor = RGBA(12,11,11,1)

/** 一级 - 333333 主色 默认色 */
let PrimaryColor = RGBA(51,51,51,1)

/** 次要 - 666666 */
let MinorColor = RGBA(102,102,102,1)

/** 第三位的 - 999999 */
let TertiaryColor = RGBA(153,153,153,1)

/** 辅助 - aaaaaa */
let AssistColor = RGBA(170,170,170,1)

/** 未选中 - cccccc */
let NormalColor = RGBA(204,204,204,1)



/** 通用红 FC5E62 */
let GeneralRedColor = RGBA(252,94,98,1)

/** 辅助蓝 FEB4FC */
let AssistBlue = RGBA(94,180,252,1)

