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


    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var tapGR: UITapGestureRecognizer!
    @IBOutlet var tapNickName: UITapGestureRecognizer!
    
    @IBOutlet weak var label: UILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置允许交互属性
        imageView.isUserInteractionEnabled = true
        label.isUserInteractionEnabled = true
        //label.text = "ニックネーム"
        label.text = UserDefaults.standard.string(forKey: "nickName")
        
        


    }
    
    
    @IBAction func tapNicknameHandler(_ sender: Any) {
        
        //初始化UITextField
        var inputText: UITextField = UITextField();
        let alertAction = UIAlertController.init(title: nil, message: "ニックネームを入力してください", preferredStyle: .alert)
        
        //確認
        let ok = UIAlertAction.init(title: "確認", style: .default, handler: {
            
            (action: UIAlertAction) -> Void in
    
           //保存
            UserDefaults.standard.set(inputText.text, forKey: "nickName")
            self.label.text = UserDefaults.standard.string(forKey: "nickName")

            
        })
        
        let cancel = UIAlertAction.init(title: "キャンセル", style: .cancel, handler: nil)
        
        alertAction.addAction(ok)
        alertAction.addAction(cancel)
        alertAction.addTextField { (textField) in
            inputText = textField
            inputText.placeholder = "ニックネーム"
        }
        
        self.present(alertAction,animated: true,completion: nil)
        
    }
    
    
    
    @IBAction func tapHandler(_ sender: Any) {
        //label.text = "aaa"
        let actionSheet = UIAlertController(title: "プロフィール設定", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        
        let takePhotos = UIAlertAction(title: "写真を撮る", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
                
            }
            else
            {
                print("simulatorではカメラを開けることができません");
            }
            
        })
        let selectPhotos = UIAlertAction(title: "画像アルバン", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
}


        extension UserViewController: UIImagePickerControllerDelegate {
            // ユーザーが写真を選んた後
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

                imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
                
                UserDefaults.standard.set(UIImageJPEGRepresentation((info[UIImagePickerControllerOriginalImage] as? UIImage ?? nil)!, 0.8), forKey: "userImage")
                
                let imageDate:NSData = UserDefaults.standard.object(forKey: "userImage") as! NSData
                imageView.image = UIImage(data:imageDate as Data)

                
                // 必须写这行，否则拍照后点击重新拍摄或使用时没有返回效果。
                picker.dismiss(animated: true, completion: nil)

            }
        }

        extension UserViewController: UINavigationControllerDelegate {
            // do nothing
        }



//extension UserViewController: UIAlertViewDelegate{
//
//
//}


