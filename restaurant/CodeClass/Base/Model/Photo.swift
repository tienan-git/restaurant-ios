//
//  Photo.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit
import SDWebImage

open class Photo: NSObject {
    var image: UIImage?
    var placeholderImage: UIImage?
    var imageURL: URL?
    var smallImageUrl: URL?
    
    override public init() {
        super.init()
    }
    
    public init(image: UIImage?) {
        super.init()
        self.image = image
    }
    
    public init(imageUrl: URL?) {
        super.init()
        self.imageURL = imageUrl
    }
    
    open class func downloadPhoto(_ imageUrl: URL?, placeholder: UIImage, closure: @escaping (UIImage?, NSError?) -> Void) {
        guard let _ = imageUrl else {
            closure(placeholder, nil)
            return
        }
        
        SDWebImageManager.shared().loadImage(
            with: imageUrl,
            options: .lowPriority,
            progress: nil,
            completed: { (image, data, error, cacheType, finished, imageURL) in
                DispatchQueue.main.async {
                    closure(image ?? placeholder, error as NSError?)
                }
        }
        )
    }
    
    open func downloadPhoto(_ closure: @escaping (UIImage?, NSError?) -> Void) -> Void {
        SDWebImageManager.shared().loadImage(
            with: self.imageURL,
            options: .lowPriority,
            progress: nil,
            completed: { [weak self] (image, data, error, cacheType, finished, imageURL) in
                DispatchQueue.main.async {
                    self?.image = image
                    closure(image ?? self?.placeholderImage, error as NSError?)
                }
            }
        )
    }
}

