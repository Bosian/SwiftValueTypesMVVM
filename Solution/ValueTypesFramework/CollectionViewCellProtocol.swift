//
//  CollectionViewCellProtocol.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/26.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

protocol CollectionViewCellProtocol: AnyObject {
    var pageViewController: UIViewController? { get }
    var collectionView: UICollectionView? { get }
}

extension CollectionViewCellProtocol where Self: UICollectionViewCell
{
    weak var pageViewController: UIViewController? {
        return self.collectionView?.delegate as? UIViewController
    }
    
    weak var collectionView: UICollectionView? {
        return self.superview?.superview as? UICollectionView
    }
}
