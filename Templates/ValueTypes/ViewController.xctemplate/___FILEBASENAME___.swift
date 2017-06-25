//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import ValueTypesFramework

class ___FILEBASENAMEASIDENTIFIER___: BaseViewController, Viewer {
    
    
    
    typealias ViewModelType = <#___FILEBASENAMEASIDENTIFIER___#>ViewModel
    var viewModel: ViewModelType! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModelType()
    }
}
