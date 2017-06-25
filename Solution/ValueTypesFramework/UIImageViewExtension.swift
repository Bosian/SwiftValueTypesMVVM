//
//  UIImageViewExtendsion.swift
//  BrandApp
//
//  Created by Bobson on 2016/1/29.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit
import Library

extension UIImageView {

    /**
     * 背景下載圖片
     */
    public func setImage(url: String?, callback: ((_ imageView: UIImageView?, _ image: UIImage?) -> Void)? = nil) -> URLSessionDataTask?
    {
        return Utilities.downloadImageAsync(url) { [weak self] (image, error) in
            
            self?.image = image
            
            callback?(self, image)
        }
        
    }
}
