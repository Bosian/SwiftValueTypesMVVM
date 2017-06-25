//
//  UIViewExtension.swift
//  BrandApp
//
//  Created by Bobson on 2016/2/19.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

extension UIView {
   
    /**
     * 搖動動畫
     */
    
    public func shake()
    {
        let view = self
        
        if #available(iOS 9.0, *)
        {
            let animation = CASpringAnimation(keyPath: "position")
            let fromPosition = CGPoint( x: view.center.x - 30, y: view.center.y)
            let toPosition = CGPoint( x: view.center.x, y: fromPosition.y)
            
            animation.fromValue = NSValue(cgPoint: fromPosition)
            animation.toValue = NSValue(cgPoint: toPosition)
            
            animation.mass = 1.0
            animation.stiffness = 500.0
            animation.damping = 10.8
            
            if animation.responds(to: #selector(getter: CASpringAnimation.settlingDuration))
            {
                animation.duration = animation.settlingDuration
            }
            else
            {
                animation.duration = 1.3203680233550978
            }
            
            view.layer.add(animation, forKey: nil)
        }
        else
        {
            let animation = CABasicAnimation(keyPath: "position")
            let fromPosition = CGPoint( x: view.center.x - 30, y: view.center.y)
            let toPosition = CGPoint( x: view.center.x, y: fromPosition.y)
            
            animation.fromValue = NSValue(cgPoint: fromPosition)
            animation.toValue = NSValue(cgPoint: toPosition)
            
            view.layer.add(animation, forKey: nil)
        }
        
        
        
        view.becomeFirstResponder()
    }
}

// MARK: - 陰影效果
extension UIView {
    
    /**
     陰影效果 位移
     */
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    /**
     陰影效果 透明度
     */
    @IBInspectable public var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        
        set {
            
            self.layer.shadowOpacity = newValue
        }
    }
    
    /**
     陰影效果 半徑
     */
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    /**
     陰影效果 顏色
     */
    @IBInspectable public var shadowColor: UIColor? {
        get {
            guard let cgColor = self.layer.shadowColor else {
                return nil
            }
            
            return UIColor(cgColor: cgColor)
        }
        
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    /**
     加入陰影效果
     */
    public func shadow(_ shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat, shadowColor: CGColor?)
    {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor
    }
}

extension UIView {
    
    /**
     框線粗細
     */
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    /**
     框線效果 顏色
     */
    @IBInspectable public var borderColor: UIColor? {
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
     外框 圓角半徑
     */
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
