//
//  ZCHomeModel.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/30.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
//import SwiftyJSON

enum ZCAuctionState: Int {
    /// 筹备中
    case prepare = 1
    /// 热拍中
    case hotsale = 2
    /// 预展中
    case presell = 3
    
    func introduce() -> (title: String, color:UIColor) {
        switch self {
        case .prepare:
            return ("筹备中", AssistBlue)
        case .hotsale:
            return ("热拍中", GeneralRedColor)
        case .presell:
            return ("预展中", RGBA(250, 200, 66, 1))
        }
    }
    
    
    
}


class ZCHomeModel: ZCBaseModel {
    var have_read: Bool = false
    var adlist: [AdModel]!
    var aucList: [AucModel]!
    var messageList: [String]!
    var recommenedGoodsList: [RecommenedGoodsModel]!
    
    init(json: JSON) {
        have_read = json["have_read"].boolValue
        messageList = (json["messageList"].arrayObject as! [String])
        
        var adArray:[AdModel] = []
        for item in json["adlist"].arrayValue {
            let adModel = AdModel.init(json: item)
            adArray.append(adModel)
        }
        adlist = adArray
        
        var aucArray:[AucModel] = []
        for (index,item) in json["aucList"].arrayValue.enumerated() {
            if index > 3 {
                break
            }
            let aucModel = AucModel.init(json: item)
            aucArray.append(aucModel)
        }
        aucList = aucArray

        var goodsArray:[RecommenedGoodsModel] = []
        for item in json["recommenedGoodsList"].arrayValue {
            let goodsModel = RecommenedGoodsModel.init(json: item)
            goodsArray.append(goodsModel)
        }
        recommenedGoodsList = goodsArray

        
    }
    
    
    
}

class AdModel: ZCBaseModel {
    var title: String!
    var url: String!
    var image: String!
    
    init(json: JSON) {
        title = json["title"].stringValue
        url = json["url"].stringValue
        image = json["image"].stringValue
    }
}

class AucModel: ZCBaseModel {
    var id: String!
    var smallimage: String!
    var backimage: String!
    var name: String!
    var sign: String!
    var starttime: String!
    var endtime: String!
    var weekday: String!
    
    var is_use: Int = 1
    var state: ZCAuctionState!
    

    init(json: JSON) {
        id = json["id"].stringValue
        smallimage = json["smallimage"].stringValue
        backimage = json["backimage"].stringValue
        name = json["name"].stringValue
        sign = json["sign"].stringValue
        starttime = json["starttime"].stringValue
        endtime = json["endtime"].stringValue
        let start = starttime.time(formatterStr: "MM月dd号 hh:mm")
        let end = endtime.time(formatterStr: "MM月dd号 hh:mm")
        weekday = starttime.weekday()
        starttime = "开始时间:\(start)(\(starttime.weekday()))"
        endtime = "结束时间:\(end)(\(endtime.weekday()))"
        is_use = json["is_use"].intValue
        state = ZCAuctionState(rawValue: is_use)
    }

    
    
}

class RecommenedGoodsModel: ZCBaseModel {

    var id: String!
    var name: String!
    var first_price: String!
    var priceAtt: NSAttributedString!
    
    var goodimages: String!
    var is_type: String!
    var imgHeight: CGFloat = 0
    
    var rowHeight: CGFloat = 0

    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        first_price = "起拍价￥" + json["first_price"].stringValue
        goodimages = json["goodimages"].stringValue
        is_type = json["is_type"].stringValue
        
        let nameHeight = name.height(SCREEN_WIDTH-FitWidth(34)/2, font: UIFont.systemFont(ofSize: FontSize(15)), lineBreakMode: nil, lines: 2)
        let priceHeight = first_price.height(SCREEN_WIDTH-FitWidth(34)/2, font: UIFont.systemFont(ofSize: FontSize(12)), lineBreakMode: nil)
        priceAtt = NSMutableAttributedString.colorfully(full: [first_price: [.foregroundColor: GeneralRedColor, .font: UIFont.systemFont(ofSize: FontSize(12))]], specials: ["起拍价": [.foregroundColor: PrimaryColor]])
        
        imgHeight = CGFloat(arc4random()%80 + 200)
        rowHeight = imgHeight + nameHeight + priceHeight + FitWidth(40)
    }

}

