//
//  TableViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol Keyboarder: AnyObject {

    /// 鍵盤是否已顯示
    var isKeyboardShown: Bool { get set }

    /// ScrollView Content Inset (鍵盤調整使用)
    var scrollViewOriginalContentInset: UIEdgeInsets { get set }

    /// 取得SrollView
    var scrollView: UIScrollView? { get }

    /// 鍵盤將顯示 Register Object
    var observerForKeyboardWillShowNotification: NSObjectProtocol? { get set }

    /// 鍵盤已顯示 Register Object
    var observerForKeyboardDidShowNotification: NSObjectProtocol? { get set }

    /// 鍵盤將隱藏 Register Object
    var observerForKeyboardWillHideNotification: NSObjectProtocol? { get set }
    
    var observerForKeyboardDidHideNotification: NSObjectProtocol? { get set }

    /// 鍵盤的Frame將改變 Register Object
    var observerForKeyboardWillChangeFrameNotification: NSObjectProtocol? { get set }

    /// 鍵盤的Frame已改變 Register Object
    var observerForKeyboardDidChangeFrameNotification: NSObjectProtocol? { get set }

    /// 註冊鍵盤通知 (viewDidLoad 時呼叫)
    func registerKeyboard()

    /// 解註冊鍵盤通知 (deinit 時呼叫)
    func unRegisterKeyboard()

    /// 鍵盤將顯示
    func keyboardWillShow(_ notification: Notification)

    /// 鍵盤已顯示
    func keyboardDidShow(_ notification: Notification)

    /// 鍵盤將隱藏
    func keyboardWillHide(_ notification: Notification)

    func keyboardDidHide(_ notification: Notification)

    /// 鍵盤Frame將改變
    func keyboardWillChangeFrame(_ notification: Notification)

    /// 鍵盤Frame已改變
    func keyboardDidChangeFrame(_ notification: Notification)
}

extension Keyboarder where Self: UIViewController {
    /// 註冊鍵盤通知 (viewDidLoad 時呼叫)
    public func registerKeyboard() {
        let notificationCenter = NotificationCenter.default

        observerForKeyboardWillShowNotification = notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardWillShow(notification)
        }

        observerForKeyboardDidShowNotification = notificationCenter.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardDidShow(notification)
        }

        observerForKeyboardWillHideNotification = notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardWillHide(notification)
        }
        
        observerForKeyboardDidHideNotification = notificationCenter.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardDidHide(notification)
        }

        observerForKeyboardWillChangeFrameNotification = notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardWillChangeFrame(notification)
        }

        observerForKeyboardDidChangeFrameNotification = notificationCenter.addObserver(forName: UIResponder.keyboardDidChangeFrameNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.keyboardDidChangeFrame(notification)
        }

        // 取得原來的設定(鍵盤使用)
        if let scrollView = self.scrollView {
            scrollViewOriginalContentInset = scrollView.contentInset
        }
    }

    /// 解註冊鍵盤通知 (deinit 時呼叫)
    public func unRegisterKeyboard() {
        guard let observerForKeyboardWillShowNotification = observerForKeyboardWillShowNotification,
              let observerForKeyboardDidShowNotification = observerForKeyboardDidShowNotification,
              let observerForKeyboardWillHideNotification = observerForKeyboardWillHideNotification,
              let observerForKeyboardDidHideNotification = observerForKeyboardDidHideNotification,
              let observerForKeyboardWillChangeFrameNotification = observerForKeyboardWillChangeFrameNotification,
              let observerForKeyboardDidChangeFrameNotification = observerForKeyboardDidChangeFrameNotification else {

                return
        }

        let notificationCenter = NotificationCenter.default

        notificationCenter.removeObserver(observerForKeyboardWillShowNotification)
        notificationCenter.removeObserver(observerForKeyboardDidShowNotification)
        notificationCenter.removeObserver(observerForKeyboardWillHideNotification)
        notificationCenter.removeObserver(observerForKeyboardDidHideNotification)
        notificationCenter.removeObserver(observerForKeyboardWillChangeFrameNotification)
        notificationCenter.removeObserver(observerForKeyboardDidChangeFrameNotification)
    }

    public func keyboardWillShowHandler(_ notification: Notification) {
        guard let scrollView = scrollView else {
            return
        }

        guard let userInfo = notification.userInfo else {
            return
        }

        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }

        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
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
            scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
        })

        isKeyboardShown = true
    }
    
    public func keyboardWillHideHandler(_ notification: Notification) {
        isKeyboardShown = false
        
        guard let scrollView = scrollView else {
            return
        }
        
        guard let keyboardAnimationDetail = notification.userInfo as? [String: Any] else {
            return
        }
        
        guard let duration = keyboardAnimationDetail[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: duration, animations: { [weak self] () -> Void in
            
            guard let weakSelf = self else {
                return
            }
            
            scrollView.contentInset.bottom = weakSelf.scrollViewOriginalContentInset.bottom
            scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
        })
    }
    
    public func keyboardDidHideHandler(_ notification: Notification) {

    }
    
    /// 鍵盤將顯示
    public func keyboardWillShow(_ notification: Notification) {
        keyboardWillShowHandler(notification)
    }

    /// 鍵盤已顯示
    public func keyboardDidShow(_ notification: Notification) {

    }

    /// 鍵盤將隱藏
    public func keyboardWillHide(_ notification: Notification) {
        keyboardWillHideHandler(notification)
    }
    
    public func keyboardDidHide(_ notification: Notification) {

    }

    /// 鍵盤Frame將改變
    public func keyboardWillChangeFrame(_ notification: Notification) {

    }

    /// 鍵盤Frame已改變
    public func keyboardDidChangeFrame(_ notification: Notification) {

    }
}
