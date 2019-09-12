//
//  ZCSubmitCircleVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/8/13.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit

class ZCSubmitCircleVC: ZCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
    }
    
    func setupUI() {
        let contentView = UIView(color: UIColor.white)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textView)
        contentView.addSubview(photoView)
        contentView.addSubview(forbiddenLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(bottomView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).inset(FitWidth(10))
            make.left.equalToSuperview().inset(FitWidth(12))
            make.right.equalToSuperview().inset(FitWidth(20))
            make.height.equalTo(FitWidth(120))
        }
        
        photoView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp_bottom).offset(FitWidth(30))
            make.left.right.equalTo(textView)
            make.height.equalTo(124)
        }

        forbiddenLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).inset(FitWidth(12))
            make.right.equalTo(contentView).inset(FitWidth(20))
            make.top.equalTo(photoView.snp_bottom).offset(FitWidth(10))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(forbiddenLabel.snp_bottom).offset(FitWidth(15))
            make.height.equalTo(FitWidth(12))
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(FitWidth(99))
            make.bottom.equalTo(contentView)
        }
        
    }
    
    
    
    override func configCustomNav() {
        self.view.addSubview(customNavBar)
        customNavBar.title = "创建圈子"
        customNavBar.setRightButton(withTitle: "发布", color: GeneralRedColor)
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
        
        if textView.text!.length <= 0 || photos.isEmpty || self.huati.length <= 0 {
            ZCAlertTools.showWith(ViewController: self, title: "内容不完整", message: nil, buttonTitle: "确定", buttonStyle: .default)
            return
        }
        
        
        
        
        var imageKeys: [String] = []
        let source = dataArrayFrom(photos)
        
        QiniuTools.sharedInstance.upImageDatas(images: source.datas, result: { (progress, imageKey) in
            imageKeys.append(imageKey)
            
        }) { //complete
            print("imageKeys:\(imageKeys)")
            
            let params:[String: String] = ["content":self.textView.text,"images":imageKeys.joined(separator: ","), "gambit":self.huati, "type":self.quanxian, "wide":source.width, "tall": source.height]
            
            NetworkHelper.postRequestWith(url: kaddCircle, params: params, success: { (response) in
                
            }, failed: { (error) in
                
            })
        }
        

    }
    
    /// image数组转 data数组，并返回第一个元素的宽高(pixel)
    func dataArrayFrom(_ photoModels:[HXPhotoModel]) -> (datas:[Data], width:String, height:String) {
        
        var tempArray: [Data] = []
        var imgWidth:String = ""
        var imgHeight:String = ""
        
        
        for (index, model) in photoModels.enumerated() {
            
            if let asset = model.asset {// 选中系统相册，取原图 有值，previewPhoto & thumbPhoto 为nil
                if index == 0 {
                    imgWidth = String(asset.pixelWidth)
                    imgHeight = String(asset.pixelHeight)
                }
                
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                options.resizeMode = PHImageRequestOptionsResizeMode.exact
                PHImageManager.default().requestImageData(for: asset, options: options) { (imageData, dataUTI, orientation, info) in
                    
                    print("image:\(imageData)  info:\(info)")
                    var finish: Bool = false
                    
                    if let result = info {
                        finish = !((result[PHImageCancelledKey] != nil) || (result[PHImageErrorKey] != nil))
                    }
                    
                    if imageData != nil && finish {
                        //                        tempArray.append()
                        tempArray.append(imageData!)
                    }
                    
                    
                    
                }
                
                //                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
                //                    print("image:\(image)  info:\(info)")
                //                    var finish: Bool = false
                //
                //                    if let result = info {
                //                        finish = !((result[PHImageCancelledKey] != nil) || (result[PHImageErrorKey] != nil))
                //                    }
                //
                //                    if image != nil && finish {
                //                        tempArray.append(image!)
                //                    }
                //
                //                }
                
                
                
            }else {
                print("imageSize: \(String(describing: model.imageSize)) preViewSize:\(String(describing: model.previewPhoto?.size)) thumbSize:\(String(describing: model.thumbPhoto?.size))")
                
                
                if let preView = model.previewPhoto {
//                    tempArray.append(preView)
                    tempArray.append(preView.jpegData(compressionQuality: 0.8)!)
                    
                    if index == 0 {
                        imgWidth = String(preView.cgImage!.width)
                        imgHeight = String(preView.cgImage!.height)
                    }
                 }else {
//                    tempArray.append(model.thumbPhoto!)
                    let thumbPhoto = model.thumbPhoto!
                    
                    tempArray.append((thumbPhoto.jpegData(compressionQuality: 0.8))!)
                    if index == 0 {
                        imgWidth = String(thumbPhoto.cgImage!.width)
                        imgHeight = String(thumbPhoto.cgImage!.height)
                    }

                }
            }
            
        }
        
        return (tempArray, imgWidth, imgHeight)
    }
    
    
    
    /// 跳转选择话题
    @objc func cellHuatiButtonAction(_ button: ResizeSpacingButton) {
        let vc = ZCSubmitHuatiVC()
        vc.backCompleteEnclosure = {(huati: String) in
            button.setTitle(huati, for: .normal)
            button.setImage(UIImage(named: "circle_arrowRight_lightGray"), for: .normal)
            button.imagePosition(.Right, margin: 0)
            self.huati = "#" + huati
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 跳转选择权限
    @objc func cellQuanxianButtonAction(_ button: ResizeSpacingButton) {
        let vc = ZCSubmitQuanxianVC()
        vc.backCompleteEnclosure = {(quanxian: String) in
            button.setTitle(quanxian, for: .normal)
            button.setImage(UIImage(named: "circle_arrowRight_lightGray"), for: .normal)
            button.imagePosition(.Right, margin: 0)
            self.quanxian = quanxian == "公开" ? "0" : "1"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    lazy var textView: YYTextView = {
        let view = YYTextView()
        view.placeholderText = "写一下你想说的话吧~字数要在600字以内哟"
        view.placeholderTextColor = AssistColor
        view.placeholderFont = UIFont.systemFont(ofSize: FontSize(15))
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        view.typingAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize(15)), NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.kern:1]
        view.delegate = self
        return view
    }()
    
    let forbiddenLabel = UILabel(text: "禁止发表违法乱纪，危害社会的言论", textColor: GeneralRedColor, font: UIFont.systemFont(ofSize: FontSize(12)))
    let lineView = UIView(color: LineColor)//item["imageName"]!, title: item["title"]!, selectTitle: item["selectTitle"]!
    let bottomView = ZCSubmitBottomView(frame: CGRect(x: 0, y: 0, w: SCREEN_WIDTH, h: FitWidth(99)), items: ["imageName":"circle_huati","title":"参与话题","selectTitle":"选择合适的话题会有更多的赞哦"],["imageName":"circle_tixing","title":"谁可以看","selectTitle":"公开"])
    
    
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: NavBarHeight, w: SCREEN_WIDTH, h: SCREEN_HEIGHT-NavBarHeight))
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = true
        scroll.backgroundColor = HexColor("0xf5f5f5")
        return scroll
    }()
    
    
    lazy var photoView: HXPhotoView = {
        let view = HXPhotoView(manager: manager)!
        view.outerCamera = false
        view.previewStyle = HXPhotoViewPreViewShowStyle.dark
        view.previewShowDeleteButton = true
        view.showAddCell = true
        view.delegate = self
        view.collectionView.reloadData()
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var manager: HXPhotoManager = {
        let manag = HXPhotoManager.init(type: HXPhotoManagerSelectedType.photo)
        manag?.configuration.openCamera = true
        manag?.configuration.lookLivePhoto = true
        manag?.configuration.photoMaxNum = 9
        manag?.configuration.videoMaxNum = 0
        manag?.configuration.maxNum = 9
        manag?.configuration.videoMaximumSelectDuration = 15
        manag?.configuration.videoMinimumSelectDuration = 0
        manag?.configuration.videoMaximumDuration = 15
        manag?.configuration.creationDateSort = false
        manag?.configuration.saveSystemAblum = true
        manag?.configuration.showOriginalBytes = true
        manag?.configuration.selectTogether = false
        manag?.configuration.replaceCameraViewController = true
        manag?.configuration.shouldUseCamera = {(viewController: UIViewController?, cameraType: HXPhotoConfigurationCameraType, manager: HXPhotoManager?) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = false
            imagePickerController.videoQuality = UIImagePickerController.QualityType.typeHigh
            imagePickerController.videoMaximumDuration = 15
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            imagePickerController.navigationController?.navigationBar.tintColor = UIColor.white
            imagePickerController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            viewController!.present(imagePickerController, animated:true)
        }
        
        
        return manag!
    }()
    
    var photos:[HXPhotoModel] = []
    
    var huati:String = ""
    var quanxian:String = "0"
    
    
    
    deinit {
        print("\(String(describing: self)) deinit complete")
    }

    
}

extension ZCSubmitCircleVC: YYTextViewDelegate {
    

    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let fullString: String = textView.text + text
        if fullString.count <= 600 || text == ""{
            return true
        }else {
            textView.text = String(fullString.prefix(600))
            return false
        }
    }
    
}

extension ZCSubmitCircleVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("picker finished")
        picker.dismiss(animated: true, completion: nil)
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        let model: HXPhotoModel
        
        if mediaType == kUTTypeImage as String {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            model = HXPhotoModel(image: image)!
            if manager.configuration.saveSystemAblum {
                HXPhotoTools.savePhotoToCustomAlbum(withName: manager.configuration.customAlbumName, photo: image)
            }
            
        }else  {//mediaType == kUTTypeMovie as String

            let url = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            
            let urlAssert = AVURLAsset.init(url: url, options: [AVURLAssetPreferPreciseDurationAndTimingKey: false])
            let second = urlAssert.duration.value / Int64(urlAssert.duration.timescale)
            model = HXPhotoModel(videoURL: url, videoTime: TimeInterval(second))!
            if manager.configuration.saveSystemAblum {
                HXPhotoTools.saveVideoToCustomAlbum(withName: manager.configuration.customAlbumName, videoURL: url)
            }
            
        }
        if ((manager.configuration?.useCameraComplete) != nil) {
            manager.configuration.useCameraComplete(model)
        }
    }
    
    
}


extension ZCSubmitCircleVC: HXPhotoViewDelegate {
    
    /**
     当view高度改变时调用
     
     @param photoView self
     @param frame 位置大小
     */
    func photoView(_ photoView: HXPhotoView!, updateFrame frame: CGRect) {
        photoView.snp.updateConstraints { (make) in
            make.height.equalTo(frame.height)
        }
    }
    
    
    /**
     照片/视频发生改变、HXPohotView初始化、manager赋值时调用 - 选择、移动顺序、删除、刷新视图
     调用 refreshView 会触发此代理
     
     @param photoView self
     @param allList 所有类型的模型数组
     @param photos 照片类型的模型数组
     @param videos 视频类型的模型数组
     @param isOriginal 是否原图
     */
    func photoView(_ photoView: HXPhotoView!, changeComplete allList: [HXPhotoModel]!, photos: [HXPhotoModel]!, videos: [HXPhotoModel]!, original isOriginal: Bool) {
        
        print("photos:\(String(describing: photos)) isOriginal:\(isOriginal)")
        
        self.photos = photos
        let model = videos.first
        
        print("imageSize: \(String(describing: model?.imageSize)) preViewSize:\(String(describing: model?.previewPhoto?.size)) thumbSize:\(String(describing: model?.thumbPhoto?.size))")
        
        
        
    }
    
    
    
}
