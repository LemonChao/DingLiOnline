//
//  QiniuTools.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/13.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

let kQiniuBucket = "ceshi-dlmp"
let kQiniuAccessKey = "RSQ3PQW6-75ny9E_vGzpWSHlCAo6G0tExWGFGYH8"
let kQiniuSecretKey = "rqGlw26QzkL3hUiT77os1FXpp1i1E6CASs5Cgxj4"


class QiniuTools {
    static var filePath = String()
    static var sharedInstance = QiniuTools()
    
    var Index : Int = 0
    
    init() {
        
    }
    
    func token() -> String {
        return self.createQiniuToken(fileName: kQiniuBucket)
    }
    
    func hmacsha1WithString(str: String, secretKey: String) -> NSData {
        
        let cKey  = secretKey.cString(using: String.Encoding.ascii)
        let cData = str.cString(using: String.Encoding.ascii)
        
        var result = [CUnsignedChar](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
        let hmacData: NSData = NSData(bytes: result, length: (Int(CC_SHA1_DIGEST_LENGTH)))
        return hmacData
    }
    
    func createQiniuToken(fileName: String) -> String {
        
        let oneHourLater = NSDate().timeIntervalSince1970 + 3600
        // 这里deadline要转为整型，不能是字符串，不能是浮点型(float，double)
        let putPolicy: Dictionary = ["scope": kQiniuBucket, "deadline": Int(oneHourLater)] as [String : Any]
        let data: Data! = try? JSONSerialization.data(withJSONObject: putPolicy, options: [])
        let jsonString: String = String(data:data as Data,encoding: String.Encoding.utf8)!
        let encodedPutPolicy = QNUrlSafeBase64.encode(jsonString as String)
        let sign = self.hmacsha1WithString(str: encodedPutPolicy!, secretKey: kQiniuSecretKey)
        let encodedSign = QNUrlSafeBase64.encode(sign as Data?)
        
        return kQiniuAccessKey + ":" + encodedSign! + ":" + encodedPutPolicy!
    }
    
    /// progrressHandler‘s key一直和 manager.put(key:)中key值相等，如果manager.put(key: nil) progrressHandler‘s key 一直为nil，上传成功 complete返回七牛云生成的key(图片名称)
    ///
    /// - Parameters:
    ///   - image: 上传时指定图片七牛云存储名称
    ///   - result: 上传结果反馈 result(<1, nil)上传中，result(1.0,imageKey)上传成功，
    func uploadImageData(image:Data , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> Void, failed: @escaping (_ errorInfo: QNResponseInfo) -> Void) {
        
        
        let token = self.token()
        
        let opt = QNUploadOption(mime: nil, progressHandler: {(key, progres) in
            
            result(progres, nil)
        }, params: nil, checkCrc: true, cancellationSignal: nil)
        
        var cutdownData : Data!
        if (image.count < 9999) {
            cutdownData = image
        } else if (image.count < 99999) {
            let nowImage = UIImage.init(data: image)!
            cutdownData = nowImage.jpegData(compressionQuality: 0.6)
        } else {
            let nowImage = UIImage.init(data: image)!
            cutdownData = nowImage.jpegData(compressionQuality: 0.6)
        }
        
        // 上传失败 resp = nil，可据此判断上传成败
        if let manager = QNUploadManager() {
            manager.put(cutdownData, key: nil, token: token, complete: { (Info, key, resp) in
                print("Info:\(String(describing: Info))  resp:\(String(describing: resp))")
                if (Info?.isConnectionBroken)! {
                    print("网络连接错误")
                    return
                }
                
                if let response = resp {
                    let imageKey = response["key"] as! String
                    result(1.0, imageKey)
                }else {
                    failed(Info!)
                }
            }, option: opt)
        }
        
    }
    
    func uploadVideoData(video:Data , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> Void) {
        
        
        let token = self.token()
        
        let opt = QNUploadOption(mime: nil, progressHandler: {(key, progres) in
            
            result(progres, nil)
        }, params: nil, checkCrc: true, cancellationSignal: nil)
        
        
        
        if let manager = QNUploadManager() {
            manager.put(video, key: nil, token: token, complete: { (Info, key, resp) in
                if (Info?.isConnectionBroken)! {
                    print("网络连接错误")
                    return
                }
                
                if let imageKey = resp?["key"] as? String {
                    
                    result(nil, imageKey)
                }
                
            }, option: opt)
        }
        
    }
    
    /// 根据数组顺序，一个一个上传
    func upVideoDatas(videos:[Data] , result: @escaping (_ progress: Float? , _ imageKey:String? ) -> (),allTasksCompletion:@escaping () -> () ) {
        
        if (Index < videos.count) {
            
            uploadVideoData(video: videos[Index], result: { (progres, imageKey) in
                
                if (imageKey != nil) {// 本次上传完成(成功)imageKey才有值,进行下一张上传
                    
                    result(progres, imageKey)
                    
                    self.Index += 1
                    
                    self.upVideoDatas(videos: videos, result: result, allTasksCompletion: allTasksCompletion)
                }
                
                
            })
        }else{
            allTasksCompletion()
            Index = 0
        }
        
    }
    
    /// 根据数组顺序，一个一个上传
    func upImageDatas(images:[Data] , result: @escaping (_ progress: Float? , _ imageKey:String ) -> Void,allTasksCompletion:@escaping () -> Void ) {
        
        if (Index < images.count) {
            
            uploadImageData(image: images[Index], result: { (progres, imageKey) in
                if (imageKey != nil) {// 本次上传完成(成功)imageKey才有值,进行下一张上传
                    self.Index += 1
                    result(Float(self.Index/images.count), QiniuHostImg+imageKey!)
                    self.upImageDatas(images: images, result: result, allTasksCompletion: allTasksCompletion)
                }

            }) { (errorInfo) in
                self.Index += 1
                self.upImageDatas(images: images, result: result, allTasksCompletion: allTasksCompletion)
            }
            
        }else{
            allTasksCompletion()
            Index = 0
        }
        
    }
}
