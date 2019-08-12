//
//  NetworkHelper.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/12.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkHelper: NSObject {

    static var userToken: String {
        set{
            UserDefaults.standard.set(newValue, forKey: UserToken)
        }
        
        get {
            if let value = UserDefaults.standard.object(forKey: UserToken) {
                return value as! String
            }
            return "123456"
        }
    }
    
    static var header: [String: String] {
        set{
            
        }
        get{
            return ["Content-Type":"application/x-www-form-urlencoded","token": userToken]
        }
    }
    
    
    
    class func postRequestWith(url: String, params: [String: Any], success: @escaping (_ response: JSON) -> Void, failed: @escaping (_ error: Error?) -> Void) {
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            
            print("URL:\(url) params:\(params)===Value:\(String(describing: response.result.value))")

            guard response.result.isSuccess else {
                print("ERROR: \(String(describing: response.error))")
                failed(response.result.error)
                return
            }
            
            if let json = response.result.value {
                let data = JSON(json)
                success(data)
            }
        }
        
    }
    
    
    class func getRequestWith(url: String, params: [String: Any], success: @escaping (_ response: JSON) -> Void, failed: @escaping (_ error: Any) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            
            print("value:\(String(describing: response.result.value))==\(AppName)==\(AppVersion)")
            
            guard response.result.isSuccess else {
                print("ERROR: \(String(describing: response.error))")
                failed(response.result.error as Any)
                return
            }
            
            if let json = response.result.value {
                let data = JSON(json)
                success(data)
            }
        }
        
    }

    
    
    
}
