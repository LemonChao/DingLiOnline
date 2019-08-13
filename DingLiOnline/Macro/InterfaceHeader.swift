//
//  InterfaceHeader.swift
//  Tibet
//
//  Created by zchao on 2019/7/19.
//  Copyright © 2019 Leyukeji. All rights reserved.
//

import Foundation

#if DEBUG
let AppBaseUrl = "http://47.108.67.205:8082"
let WebBaseUrl = "http://192.168.0.222:8080/#"
//let WebBaseUrl = "http://xoj.rzl8y.com/web"

#else
let AppBaseUrl = "http://47.108.67.205:8082"
let WebBaseUrl = "http://192.168.0.222:8080/#"

#endif

let updateVersion = AppBaseUrl + "/api/version/getVersion"
/// 获取圈子列表
let kcircleList = AppBaseUrl + "/circle/circleList"
/// 用户0：圈子点赞 1：评论点赞
let kaddUserLike = AppBaseUrl + "/circle/addUserLike"
/// 用户0：圈子取消点赞 || 1：取消评论点赞
let kdelUserLike = AppBaseUrl + "/circle/delUserLike"
/// 用户收藏圈子
let kaddUserCollect = AppBaseUrl + "/circle/addUserCollect"
/// 用户取消收藏圈子
let kdelUserCollect = AppBaseUrl + "/circle/delUserCollect"



