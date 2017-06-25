//
//  Viewer.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

/**
 *  CellViewModel UIButton 模擬checkbox 變更
 */
public protocol SwitchImageButtonPresenter: Viewer where ViewModelType: SwitchChangeable
{
    func handleSwitchImageButton(_ view: UIButton, viewModel: ViewModelType)
}

extension SwitchImageButtonPresenter
{
    public func handleSwitchImageButton(_ view: UIButton, viewModel: ViewModelType)
    {
        let image = viewModel.isSelected ? UIImage(named: "form_check_on") : UIImage(named: "form_check_off")
        view.setImage(image, for:.normal)
    }
}
