//
//  MainCellTableViewCell.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit
import ValueTypesFramework

class MainTableViewCell: UITableViewCell, Viewer, Binder {

    @IBOutlet weak var label: UILabel!
    
    typealias ViewModelType = MainCellViewModel
    var viewModel: ViewModelType! {
        didSet {
            label.text = viewModel.title
        }
    }
    
    var dataContext: Any? {
        get {
            return viewModel
        }
        
        set {
            viewModel = newValue as! ViewModelType
        }
    }
}
