//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import ValueTypesFramework

class ___FILEBASENAMEASIDENTIFIER___: BaseTableViewCell, Viewer, Binder {
    
    typealias ViewModelType = ___FILEBASENAMEASIDENTIFIER___ViewModel
    var viewModel: ViewModelType! {
        didSet {
            
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
