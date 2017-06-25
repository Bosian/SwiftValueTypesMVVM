//
//  NavigationBarExtension.swift
//  BrandApp
//
//  Created by Bobson on 2015/12/28.
//  Copyright © 2015年 Bobson. All rights reserved.
//

import UIKit


/**
 * 用來覆寫 NavigationBar
 */
extension UINavigationBar
{
    //    /**
    //     * 自定高度
    //     */
    //    public override func sizeThatFits(size: CGSize) -> CGSize {
    //
    //        var amendedSize:CGSize = super.sizeThatFits(size)
    //
    //        if let window = self.window
    //        {
    //            // 因size本身的寬度在 5.5" 上會不夠，所以取得Window的寬度來覆蓋原本的值
    //            amendedSize.width = window.bounds.width
    //
    //            // 設定自訂高度
    //            amendedSize.height = getCustomHeight()
    //
    //
    //        }
    //
    //        return amendedSize;
    //    }
    //
    //    /**
    //     * 取得設計要求的 (128px - statusBarHeight) 也就是NavigationBarHeight
    //     */
    //    func getCustomHeight() -> CGFloat
    //    {
    //        let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
    //
    //        let navigationBarHeightAndStatusBarTotalHeight: CGFloat = 128
    //        let navigationBarHeight = navigationBarHeightAndStatusBarTotalHeight // - statusBarFrame.height
    //
    //        // 取得@2x or @3x 放大倍數
    //        let screenScale = UIScreen.mainScreen().scale
    //
    //        // get @2x @3x 還原成1點的觸析度
    //        let point = navigationBarHeight / screenScale
    //        
    //        return point
    //    }
    //    
}
