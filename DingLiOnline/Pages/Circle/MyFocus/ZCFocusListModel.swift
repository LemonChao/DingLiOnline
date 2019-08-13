//
//  ZCFocusListModel.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/12.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZCFocusDataModel: NSObject {
    var list: [ZCFocusListModel]!
    
    init(jsonData: JSON) {
        
        var array: [ZCFocusListModel]! = []
        for item in jsonData["list"].arrayValue {
            let listItem = ZCFocusListModel(jsonData: item)
            array.append(listItem)
        }
        list = array
    }
}


class ZCFocusListModel: NSObject {
    var id: String!
    var userId: String!
    var content: String!
    var imagess: [String]!
    var gambit: String!
    var state: String!
    var addTime: String!
    var likeCount: Int!
    var likeState: Bool!
    var vxName: String!
    var collectState: Bool!
    var collectCount: String!
    /// 微信头像
    var litpic: String!
    var wide: String!
    var tall: String!
    
    init(jsonData: JSON) {
        id = jsonData["id"].stringValue
        userId = jsonData["userId"].stringValue
        content = jsonData["content"].stringValue
        gambit = jsonData["gambit"].stringValue
        state = jsonData["state"].stringValue
        addTime = jsonData["addTime"].stringValue
        likeCount = jsonData["likeCount"].intValue
        likeState = jsonData["likeState"].boolValue
        vxName = jsonData["vxName"].stringValue
        collectState = jsonData["collectState"].boolValue
        collectCount = jsonData["collectCount"].stringValue
        litpic = jsonData["litpic"].stringValue
        wide = jsonData["wide"].stringValue
        tall = jsonData["tall"].stringValue
        
        var array:[String]! = []
        for item in jsonData["imagess"].arrayValue {
            array.append(item.stringValue)
        }
        imagess = array
        
    }
}

/*
struct ZCFocusDataModel {
    var list: [ZCFocusListModel]!
    
    init(jsonData: JSON) {
        
        var array: [ZCFocusListModel]! = []
        for item in jsonData["list"].arrayValue {
            let listItem = ZCFocusListModel(jsonData: item)
            array.append(listItem)
        }
        list = array
    }
}


struct ZCFocusListModel {

    var id: String!
    var userId: String!
    var content: String!
    var imagess: [String]!
    var gambit: String!
    var state: String!
    var addTime: String!
    var likeCount: Int!
    var likeState: Bool!
    var vxName: String!
    var collectState: Bool!
    var collectCount: String!
    /// 微信头像
    var litpic: String!
    var wide: String!
    var tall: String!

    init(jsonData: JSON) {
        id = jsonData["id"].stringValue
        userId = jsonData["userId"].stringValue
        content = jsonData["content"].stringValue
        gambit = jsonData["gambit"].stringValue
        state = jsonData["state"].stringValue
        addTime = jsonData["addTime"].stringValue
        likeCount = jsonData["likeCount"].intValue
        likeState = jsonData["likeState"].boolValue
        vxName = jsonData["vxName"].stringValue
        collectState = jsonData["collectState"].boolValue
        collectCount = jsonData["collectCount"].stringValue
        litpic = jsonData["litpic"].stringValue
        wide = jsonData["wide"].stringValue
        tall = jsonData["tall"].stringValue
        
        var array:[String]! = []
        for item in jsonData["imagess"].arrayValue {
            array.append(item.stringValue)
        }
        imagess = array
        
    }
    
}
*/

