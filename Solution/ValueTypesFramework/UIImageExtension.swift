//
//  UIImageExtension.swift
//  BrandApp
//
//  Created by Bobson on 2016/2/17.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

extension UIImage {

    /**
     * 裁切圖片
     */
    public func crop(_ rect: CGRect) -> UIImage {
        
        guard let cgImage = self.cgImage!.cropping(to: rect) else {
            return UIImage()
        }
        
        let cropped = UIImage(cgImage: cgImage, scale: 1.0, orientation: self.imageOrientation)
        
        return cropped
    }
    
    /**
     * 縮放圖片
     */
    public func resize(_ sizeChange: CGSize? = nil, hasAlpha: Bool = true, scale: CGFloat = 0.0) -> UIImage
    {
        let sizeChange = sizeChange ?? self.size
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }

    /**
     * 縮放圖片
     */
    public func resize(_ maxLimit: CGFloat, hasAlpha: Bool = true, scale: CGFloat = 0.0) -> UIImage
    {
        let maxLength = max(self.size.width, self.size.height)
        let originalSize: CGSize = self.size
        let ratio = maxLimit / maxLength
        
        // 保證圖大於設定的最大長度限制
        guard maxLength > maxLimit else
        {
            return self
        }
        
        let scaleWidth = originalSize.width * ratio
        let scaleHeight = originalSize.height * ratio
        let sizeChange = CGSize(width: scaleWidth, height: scaleHeight)
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }

    /**
     * 轉成PNG -> Base64
     */
    public func toBase64() -> String?
    {
        let pngData = UIImagePNGRepresentation(self)
        let base64 = pngData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64
    }
    
    /**
     * 加上浮水印
     */
    public func watermark() -> UIImage
    {
        let sizeChange = self.size
        let minLength = min(sizeChange.width, sizeChange.height)
        let watermark = UIImage(named: "Watermark")!.resize(minLength)

        UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0.0)
        
        // 畫原圖
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        // 蓋上浮水印
        watermark.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    /**
     * 取得Png的NSData
     */
    public func toPNGData() -> Data?
    {
        return UIImagePNGRepresentation(self)
    }

    /**
     * 取得Png的NSData
     */
    public func toJPGData(_ compressionQuality: CGFloat) -> Data?
    {
        return UIImageJPEGRepresentation(self, compressionQuality)
    }
    
    /**
     * 旋轉JPG圖片為正向 (預設為左轉90度)
     */
    public func rotateImage() -> UIImage {
        
        if (self.imageOrientation == UIImageOrientation.up ) {
            return self
        }
        
        UIGraphicsBeginImageContext(self.size)
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return copy!
    }
}
