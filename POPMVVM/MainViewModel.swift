//
//  MainViewModel.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

struct MainViewModel {
    
    var cellViewModels: [MainCellViewModel] = []
    
    var now: String = "POP in MVVM"
    
    var text: String = "Value types programming!"
    
    var isOn: Bool = false
    
    var index: Int = 0
    
    var image: UIImage? = #imageLiteral(resourceName: "swift-128x128_2x")
    
    init() {
        
        for f in 0..<10
        {
            let cellViewModel = MainCellViewModel(title: String(f))
            cellViewModels.append(cellViewModel)
        }
    }
}
