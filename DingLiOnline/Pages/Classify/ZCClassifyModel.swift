//
//  ZCClassifyModel.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/27.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZCClassifyModel: ZCBaseModel {
    var id: Int!
    var name: String!
    var auctionMateriaList:[ZCClassifySubModel]!
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        name = jsonData["name"].stringValue
        
        var tempArray:[ZCClassifySubModel] = []
        for item in jsonData["auctionMateriaList"].arrayValue {
            let subModel = ZCClassifySubModel(jsonData: item)
            tempArray.append(subModel)
        }
        auctionMateriaList = tempArray
    }
    
}


class ZCClassifySubModel: ZCBaseModel {
    var id: Int!
    var auctionClassId: Int!
    var name: String!
    var smallimage: String!
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        auctionClassId = jsonData[""].intValue
        name = jsonData["name"].stringValue
        smallimage = jsonData["smallimage"].stringValue
    }
    
    
}


