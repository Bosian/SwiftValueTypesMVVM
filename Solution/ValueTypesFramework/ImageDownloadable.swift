//
//  Updateable.swift
//  BooKingForUser
//
//  Created by Bobson on 2016/7/21.
//  Copyright © 2016年 Bobson. All rights reserved.
//

import UIKit

public protocol ImageDownloadable {
    var isImageDownloading: Bool { get set }
    var image: UIImage? { get set }
    var imageUrl: String { get }
}
