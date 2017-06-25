//
//  MainViewModel.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit
import ValueTypesFramework

struct MainViewModel: MutatingClosure {
    
    weak var binder: Binder?
    
    let isOn: Bool = false
    let index: Int = 0
    
    var cellViewModels: [MainCellViewModel] = []
    
    var count: Int = 0
    var now: String = "POP in MVVM"
    var text: String = "Value types programming!"
    
    let lenaImage = #imageLiteral(resourceName: "lena")
    let swiftImage = #imageLiteral(resourceName: "swift-128x128_2x")
    var image: UIImage
    
    init(binder: Binder)
    {
        self.image = swiftImage
        self.binder = binder
        
        let copySelf = self
        
        cellViewModels = (0..<10).map {
            MainCellViewModel(
                title: String($0),
                indexPath: IndexPath(row: $0, section: 0),
                tapHandler: { (indexPath, oldValue, newValue, cellViewModel) in
                    
                    var cellViewModel = cellViewModel
                    cellViewModel.title = newValue
                    
                    copySelf.mutating { $0.cellViewModels[indexPath.row] = cellViewModel }
                }
            )
        }
    }
    
    mutating func handler() {
        self.now = Date().toString("yyyy/MM/dd HH:mm:ss", locale: .current, timeZone: .current)
        
        count += 1
        
        image = (count % 2 == 0) ? swiftImage : lenaImage
    }
}
