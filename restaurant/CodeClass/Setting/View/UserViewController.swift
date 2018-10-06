//
//  UserViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/29.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import TimedSilver

class UserViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
}

extension UserViewController: UIImagePickerControllerDelegate {
    // 用户选取图片之后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 参数 UIImagePickerControllerOriginalImage 代表选取原图片，这里使用 UIImagePickerControllerEditedImage 代表选取的是经过用户拉伸后的图片。
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            // 这里对选取的图片进行你需要的操作，通常会调整 ContentMode。
            
            
            
            
            
        }
        // 必须写这行，否则拍照后点击重新拍摄或使用时没有返回效果。
        picker.dismiss(animated: true, completion: nil)
        
        
        
        
        
    }
}

extension UserViewController: UINavigationControllerDelegate {
    // 这里可以什么都不写
}
