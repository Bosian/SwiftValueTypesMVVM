//
//  Updateable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol CollectionViewLazyLoadable: Viewer {
    
    associatedtype ViewModelType: CellViewModelLazyLoadable
    
    weak var collectionView: UICollectionView! { get set }
}

extension CollectionViewLazyLoadable
{
    /**
     * tableView 滑動動畫停止
     */
    public func loadCellData(_ indexPathArray: [IndexPath]?, decelerate: Bool = false)
    {
        // 手放開時沒有動畫
        guard !decelerate else {
            return
        }
        
        guard let indexPathArray = indexPathArray else {
            return
        }
        
        viewModel.tableViewDidEndScroll(indexPathArray)
    }
}
