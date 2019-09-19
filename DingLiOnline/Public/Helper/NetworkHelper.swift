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
            return "d6fb1d8d-5a45-4805-9d40-c04b3b8b41b2"
        }
    }
    
    static var header: [String: String] {
        set{}
        get{
            return ["Content-Type":"application/x-www-form-urlencoded","token": userToken]
        }
    }
    
    class func postRequestWith(url: String, params: [String: Any]? = nil, success: @escaping (_ response: JSON) -> Void, failed: ((_ error: Error) -> Void)? = nil) {
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            
            print("URL:\(url) params:\(String(describing: params))===")
            
            switch response.result {
            case .success(let value):
                print("Value:\(String(describing: value))")
                success(JSON(value))
                
            case .failure(let error):
                print("ERROR: \(String(describing: error))")
                if let failedBlock = failed { failedBlock(error) }
            }
        }
        
    }

    
    class func getRequestWith(url: String, params: [String: Any]? = nil, success: @escaping (_ response: JSON) -> Void, failed: ((_ error: Error) -> Void)? = nil) {
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            
            print("URL:\(url) params:\(String(describing: params))===")
            
            switch response.result {
            case .success(let value):
                print("Value:\(String(describing: value))")
                success(JSON(value))
                
            case .failure(let error):
                print("ERROR: \(String(describing: error))")
                if let failedBlock = failed {
                    failedBlock(error)
                }
                
            }

            
        }
        
    }

    
    
    
}
