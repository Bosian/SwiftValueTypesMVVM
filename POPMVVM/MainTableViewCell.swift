//
//  MainCellTableViewCell.swift
//  POPMVVM
//
//  Created by 劉柏賢 on 2016/7/10.
//  Copyright © 2016年 劉柏賢. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var viewModel: MainCellViewModel! {
        didSet {
            label.text = viewModel.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
