//
//  UIState.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/8/31.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol UITextFieldStateHandler {
    func handleTextField(_ view: UITextField, value: UIState<String, Any?>)
}

extension UITextFieldStateHandler where Self: UIViewController
{
    public func handleTextField(_ view: UITextField, value: UIState<String, Any?>)
    {
        switch value {
        case .normal(value: let value):
            view.text = value
            
        case .success(value: let value, message: _, duration: _, completion: _, info: _):
            view.text = value
            
        case .error(value: let value, message: let message, duration: _, completion: _, info: _):
            
            let alert = UIAlertController(title: "Message".localize(), message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK".localize(), style: .default, handler: { (action) in
                view.text = value
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
