//
//  UIImageViewExtendsion.swift
//  BrandApp
//
//  Created by Bobson on 2016/1/29.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     按鈕 圖片及文字 左右相反
     */
    @IBInspectable public var isReverseHorizontal: Bool {
        get {
            
            let scaleX = self.transform.a
            let isEnable = scaleX < 0
            
            return isEnable
        }
        
        set {
            
            let scale: CGFloat = newValue ? -1.0 : 1.0
            
            self.transform = CGAffineTransform(scaleX: scale, y: 1.0)
            self.titleLabel?.transform = CGAffineTransform(scaleX: scale, y: 1.0)
            self.imageView?.transform = CGAffineTransform(scaleX: scale, y: 1.0)
        }
    }
    
    /**
     圖片縮放設定
     */
    @IBInspectable public var imageMode: Int {
        get {
            return self.imageView?.contentMode.rawValue ?? UIView.ContentMode.scaleAspectFill.rawValue
        }
        
        set {
            
            guard let mode = UIView.ContentMode(rawValue: newValue) else {
                return
            }
            
            self.imageView?.contentMode = mode
        }
    }
    
    /**
     陰影效果 半徑
     */
    @IBInspectable public var buttonBorderWidth: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    /**
     框線效果 顏色
     */
    @IBInspectable public var buttonBorderColor: UIColor? {
        get {
            guard let cgColor = self.layer.borderColor else {
                return nil
            }
            
            return UIColor(cgColor: cgColor)
        }
        
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    /**
     文字根㯫寬度自動縮放
     */
    @IBInspectable public var isTextFitWidth: Bool {
        get {
            return false
        }
        
        set {
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
    }
}

