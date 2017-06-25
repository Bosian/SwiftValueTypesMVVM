//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import ValueTypesFramework

struct ___FILEBASENAMEASIDENTIFIER___: MutatingClosure, ViewControllerDelegate {
    
    typealias ViewControllerType = UIViewController
    weak var viewController: ViewControllerType?
    weak var binder: Binder?
    
    init<T>(viewController: T) where T: ViewControllerType, T: Binder
    {
        self.viewController = viewController
        self.binder = viewController
        
    }
}
