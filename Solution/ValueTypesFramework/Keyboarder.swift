//
//  TableViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol Keyboarder: class {
    
    /**
     * 鍵盤是否已顯示
     */
    var isKeyboardShown: Bool { get set }
    
    /// ScrollView Content Inset (鍵盤調整使用)
    var scrollViewOriginalContentInset: UIEdgeInsets { get set }
    
    /// 取得SrollView
    var scrollView: UIScrollView? { get }
    
    /**
     * 鍵盤將顯示 Register Object
     */
    var observerForKeyboardWillShowNotification: NSObjectProtocol? { get set }
    
    /**
     * 鍵盤已顯示 Register Object
     */
    var observerForKeyboardDidShowNotification: NSObjectProtocol? { get set }
    
    /**
     * 鍵盤將隱藏 Register Object
     */
    var observerForKeyboardWillHideNotification: NSObjectProtocol? { get set }
    
    /**
     註冊鍵盤通知 (viewDidLoad 時呼叫)
     */
    func registerKeyboard()
    
    /**
     解註冊鍵盤通知 (deinit 時呼叫)
     */
    func unRegisterKeyboard()
    
    /**
     * 鍵盤將顯示
     */
    func keyboardWillShow(_ notification: Notification)
    
    /**
     * 鍵盤已顯示
     */
    func keyboardDidShow(_ notification: Notification)
    
    /**
     * 鍵盤將隱藏
     */
    func keyboardWillHide(_ notification: Notification)
}

extension Keyboarder where Self: UIViewController
{
    /**
     註冊鍵盤通知 (viewDidLoad 時呼叫)
     */
    public func registerKeyboard()
    {
        let notificationCenter = NotificationCenter.default
        
        observerForKeyboardWillShowNotification = notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardWillShow(notification)
        }
        
        observerForKeyboardDidShowNotification = notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardDidShow(notification)
        }
        
        observerForKeyboardWillHideNotification = notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardWillHide(notification)
        }
        
        // 取得原來的設定(鍵盤使用)
        if let scrollView = self.scrollView
        {
            scrollViewOriginalContentInset = scrollView.contentInset
        }
    }
    
    /**
     解註冊鍵盤通知 (deinit 時呼叫)
     */
    public func unRegisterKeyboard()
    {
        guard let observerForKeyboardWillShowNotification = observerForKeyboardWillShowNotification,
              let observerForKeyboardDidShowNotification = observerForKeyboardDidShowNotification,
                let observerForKeyboardWillHideNotification = observerForKeyboardWillHideNotification else {
                return
        }
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(observerForKeyboardWillShowNotification)
        notificationCenter.removeObserver(observerForKeyboardDidShowNotification)
        notificationCenter.removeObserver(observerForKeyboardWillHideNotification)
    }
    
    /**
     * 鍵盤將顯示
     */
    public func keyboardWillShow(_ notification: Notification)
    {
        guard let scrollView = scrollView else {
            return
        }
        
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        guard let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        #if DEBUG
            print("keyboardFrame: \(keyboardFrame)")
            print(userInfo)
        #endif
        
        UIView.animate(withDuration: duration, animations: { [weak self] () -> Void in
            
            guard let weakSelf = self else {
                return
            }
            
            scrollView.contentInset.bottom = weakSelf.scrollViewOriginalContentInset.bottom + keyboardFrame.size.height
            scrollView.scrollIndicatorInsets.bottom = scrollView.contentInset.bottom
        })
        
        isKeyboardShown = true
    }
    
    /**
     * 鍵盤已顯示
     */
    public func keyboardDidShow(_ notification: Notification)
    {
        
    }
    
    /**
     * 鍵盤將隱藏
     */
    public func keyboardWillHide(_ notification: Notification)
    {
        isKeyboardShown = false
        
        guard let scrollView = scrollView else
        {
            return
        }
        
        guard let keyboardAnimationDetail = notification.userInfo as? [String: Any] else {
            return
        }
        
        guard let duration = keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: duration, animations: { [weak self] () -> Void in
            
            guard let weakSelf = self else {
                return
            }

            scrollView.contentInset.bottom = weakSelf.scrollViewOriginalContentInset.bottom
            scrollView.scrollIndicatorInsets.bottom = scrollView.contentInset.bottom
        })
    }
    
}
