//
//  MirrorExtension.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2016/1/17.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit
import Library
import MapKit

extension Utilities
{
    public static let cache = NSCache<NSString, UIImage>()
    
    /// 取得App 顯示名稱
    public static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    
    /// 取得裝置唯一識別碼
    public static var deviceID: String
    {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    /// 取得目前App的版本 1.0.1
    public static var version: String
    {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            return ""
        }
        
        let app_version_code = infoDictionary["CFBundleVersion"] as? String ?? ""
        let app_version_name = infoDictionary["CFBundleShortVersionString"] as? String ?? ""
        let appVersion = "\(app_version_name).\(app_version_code)"
        
        return appVersion
    }
    
    /**
     * 取得目前App的版本 1.0 (只顯示前兩碼)
     */
    public static var shortVersion: String
    {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    /// 取得KeyWindow
    public static var keyWindow: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first { $0 is UIWindowScene }
        let windowScene = scene as? UIWindowScene
        let window = windowScene?.windows.first(where: \.isKeyWindow)
        return window
    }

    /**
     * 取得目前作用中的ViewController
     */
    public static var currentViewController: UIViewController?
    {
        guard let parentViewController = keyWindow?.rootViewController else {
            return nil
        }
        
        switch parentViewController
        {
        case let navigationController as UINavigationController:
            return navigationController.visibleViewController
            
        case let tabBarViewController as UITabBarController:
            
            guard let viewController = tabBarViewController.selectedViewController else
            {
                return parentViewController
            }
            
            guard let innserNavigationController = viewController as? UINavigationController else
            {
                return viewController
            }
            
            return innserNavigationController.visibleViewController
            
        default:
            return parentViewController
        }
    }
    
    /**
     * 非同步 下載圖片
     */
    public static func downloadImageAsync(_ url: String?, callback: @escaping (_ image: UIImage?, _ error: NSError?) -> Void) ->  URLSessionDataTask?
    {
        guard let urlString = url?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let image = cache.object(forKey: urlString as NSString) {
            
            // UI Thread
            DispatchQueue.main.async(execute: { () -> Void in
                callback(image, nil)
            })
            
            return nil
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard error == nil else {
                
                #if DEBUG
                    print(error?.localizedDescription)
                #endif
                
                // UI Thread
                DispatchQueue.main.async(execute: { () -> Void in
                    callback(nil, error as NSError?)
                })
                
                return
            }
            
            guard let data = data else {
                
                #if DEBUG
                    print("圖片 data is nil")
                #endif
                
                // UI Thread
                DispatchQueue.main.async(execute: { () -> Void in
                    callback(nil, NSError(domain: "圖片 data is nil", code: 1, userInfo: nil))
                })
                
                return
            }
            
            guard let image = UIImage(data: data) else {
                
                // UI Thread
                DispatchQueue.main.async(execute: { () -> Void in
                    callback(nil, NSError(domain: "圖片 data is nil", code: 1, userInfo: nil))
                })
                
                return
            }
            
            // UI Thread
            DispatchQueue.main.async(execute: { () -> Void in
                cache.setObject(image, forKey: urlString as NSString)
                
                callback(image, error as NSError?)
            })
        })
        
        return task
    }

    /**
     * 撥打電話
     */
    public static func callNumber(_ phoneNumber: String, googleAnalytics: GoogleAnalyzer) {
        
        // [事件使用] Google 分析
        googleAnalytics.googleAnalyticsEvent(phoneNumber)
        
        guard let phoneCallURL = URL(string: "tel://\(phoneNumber)") else {
            return
        }
        
        let application = UIApplication.shared
        
        guard let viewController = application.windows.first?.rootViewController else {
            return
        }
        
        guard application.canOpenURL(phoneCallURL) else {
            
            let alert = UIAlertController(title: "撥打電話", message: "無法撥打\(phoneNumber)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let alert = UIAlertController(title: "", message: "IsPhoneCall".localize().replacingOccurrences(of: "[00000000000]", with: phoneNumber), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localize(), style: .default, handler: { (action) -> Void in
            
            // 撥打
            application.open(phoneCallURL)
            
        }))
        
        alert.addAction(UIAlertAction(title: "No".localize(), style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    public static func openSafari(_ urlString: String) {
        
        guard let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let url = URL(string: urlEncoded) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    /**
     開啟系統的Wi-Fi設定頁
     */
    public static func openWiFiSettingsPage()
    {
        guard let url = URL(string: "prefs:root=WIFI") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    /**
     開啟系統的設定頁
     */
    public static func openSettingsPage()
    {
        guard let url = URL(string: "prefs:") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    /**
     店家地址
     外開地圖
     */
    public static func openMap(_ latitude: Double, longitude: Double, name: String?, phoneNumber: String?)
    {
        let currentLocation = MKMapItem.forCurrentLocation()
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        toLocation.name = name
        toLocation.phoneNumber = phoneNumber
        
        let options: [String: Any]? = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
            MKLaunchOptionsShowsTrafficKey: true
        ]
        
        MKMapItem.openMaps(with: [currentLocation, toLocation], launchOptions: options)
    }
}
