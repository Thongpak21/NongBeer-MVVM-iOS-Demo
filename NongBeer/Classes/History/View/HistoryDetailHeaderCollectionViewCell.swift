//
//  HistoryDetailHeaderCollectionViewCell.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit

class HistoryDetailHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "HistoryDetailHeaderCollectionView"
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
