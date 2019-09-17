//
//  ZCMySettingAvatarVC.swift
//  DingLiOnline
//
//  Created by zchao on 2019/9/12.
//  Copyright © 2019 leyukeji. All rights reserved.
//

import UIKit
/// 头像VC
class ZCMySettingAvatarVC: ZCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
        } else {
            automaticallyAdjustsScrollViewInsets = true
        }
        
        view.addSubview(avatarImgView)
        let topH:CGFloat = (SCREEN_HEIGHT-NavBarHeight-IndicatorHomeHeight-SCREEN_WIDTH)/2
        avatarImgView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(avatarImgView.snp_width)
            make.top.equalTo(customNavBar.snp_bottom).offset(topH)
        }
    }
    
    override func configCustomNav() {
        view.addSubview(customNavBar)
        customNavBar.title = "头像"
        customNavBar.setRightButton(withImage: UIImage(named: "mysetting_avatar"))
    }
    
    
    @objc func rightButtonAction(_ button: UIButton) {
        ZCAlertTools.showActionSheetWith(ViewController: self, title: nil, message: "更换头像", selectClosure: { (title, index) in
            print(title,index)
            if index == 2 { return }
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = index == 0 ? .camera : .photoLibrary
            self.present(imagePickerController, animated:true)
            
        }, actions: ("打开相机",.default),("从相册选择",.default),("取消",.cancel))
    }
    
    
    let avatarImgView:UIImageView = {
        let view = UIImageView(contentMode: .scaleAspectFill, image: UIImage(named: "IMG_3260.jpg"))
        view.clipsToBounds = true
        return view
    }()
    
    deinit {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

    }
    
}


extension ZCMySettingAvatarVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

        self.avatarImgView.image = image
        
    }
    
    
}
