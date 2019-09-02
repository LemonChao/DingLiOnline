//
//  InterfaceHeader.swift
//  Tibet
//
//  Created by zchao on 2019/7/19.
//  Copyright © 2019 Leyukeji. All rights reserved.
//

import Foundation

#if DEBUG
let AppBaseUrl = "http://sale.dlpm.net.cn"//sale.dlpm.net.cn
let AppBaseUrl_php = "http://auction.dlpm.net.cn"
let WebBaseUrl = "http://192.168.0.222:8080/#"
/// 七牛云上传图片域名 / 不能省略
let QiniuHostImg = "http://pvhxdhli0.bkt.clouddn.com/"

#else
let AppBaseUrl = "http://sale.dlpm.net.cn"//47.105.60.77:8080
let AppBaseUrl_php = "http://auction.dlpm.net.cn"
let WebBaseUrl = "http://192.168.0.222:8080/#"
/// 七牛云上传图片域名 / 不能省略
let QiniuHostImg = "http://pvhxdhli0.bkt.clouddn.com/"

#endif

let updateVersion = AppBaseUrl + "/api/version/getVersion"

/// 首页
/// 首页内容
let khomeIndex = AppBaseUrl_php + "/api/index"


/// 分类模块
/// 一二级分类
let kselectClassify = AppBaseUrl + "/classify/selectClassify"


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
/// 发布圈子
let kaddCircle = AppBaseUrl + "/circle/addCircle"


/// 个人中心
let kuserInfo = AppBaseUrl_php + "/api/user/userinfo"


