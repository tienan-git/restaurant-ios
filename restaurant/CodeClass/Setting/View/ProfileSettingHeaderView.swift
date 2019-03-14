//
//  ProfileSettingHeaderView.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//
@objc public protocol ProfileSettingHeaderViewDelegate: NSObjectProtocol {
    func headerViewIconButtonTapped(_ view: ProfileSettingHeaderView)
}

private let iconnButtonSize = CGSize(width: 70, height: 70)

open class ProfileSettingHeaderView: UIView {
    
    let iconButton: UIButton! = UIButton()
    weak var delegate: ProfileSettingHeaderViewDelegate?
    
    required public init(delegate: ProfileSettingHeaderViewDelegate)  {
        super.init(frame: CGRect(x: 0, y: 0, width: kCommonDeviceWidth, height: 100))
        self.delegate = delegate
        self.backgroundColor = .white
        iconButton.frame = CGRect(x: (kCommonDeviceWidth - iconnButtonSize.width) / 2,
                                           y: (self.height - iconnButtonSize.height) / 2,
                                           width: iconnButtonSize.width,
                                           height: iconnButtonSize.height)
        iconButton.clipsToBounds = true
        iconButton.layer.cornerRadius = iconButton.height / 2
        iconButton.layer.borderWidth = 2.0
        iconButton.layer.borderColor = UIColor.white.cgColor
        iconButton.imageView?.contentMode = .scaleToFill
        iconButton.contentVerticalAlignment = .fill
        iconButton.contentHorizontalAlignment = .fill
        iconButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(iconButton)
        
        let image: UIImage = UIImage(named: "img_profile_camera")!
        
        let cameraButton: UIButton! = UIButton()
        cameraButton.viewSize = CGSize(width: image.size.width, height: image.size.height)
        cameraButton.setImage(image, for: .normal)
        cameraButton.right = iconButton.right + 12.0
        cameraButton.bottom = iconButton.bottom - 2.0
        cameraButton.clipsToBounds = true
        cameraButton.layer.cornerRadius = cameraButton.height / 2
        cameraButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(cameraButton)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var user: User? {
        didSet {
            DBLog(user?.photo?.image)
            if user?.photo?.image != nil {
                iconButton.setImage(user?.photo?.image, for: .normal)
            } else {
                iconButton.setImage(UIImage(named: "img_thumbnail_user"), for: .normal)
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if self.delegate!.responds(to: #selector(ProfileSettingHeaderViewDelegate.headerViewIconButtonTapped(_:))){
            self.delegate!.headerViewIconButtonTapped(self)
        }
    }
}
