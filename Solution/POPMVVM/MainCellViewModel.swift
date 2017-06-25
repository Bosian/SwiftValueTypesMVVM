//
//  MainCellViewModel.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

struct MainCellViewModel {
    
    var title: String
    
    let indexPath: IndexPath
    let tapHandler: (_ indexPath: IndexPath, _ oldValue: String, _ newValue: String, _ viewModel: MainCellViewModel) -> Void
    
    init(title: String,
         indexPath: IndexPath,
         tapHandler: @escaping (_ indexPath: IndexPath, _ oldValue: String, _ newValue: String, _ viewModel: MainCellViewModel) -> Void
        )
    {
        self.title = title
        self.indexPath = indexPath
        self.tapHandler = tapHandler
    }
}
