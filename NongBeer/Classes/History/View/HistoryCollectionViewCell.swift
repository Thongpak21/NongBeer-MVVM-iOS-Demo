//
//  HistoryCollectionViewCell.swift
//  NongBeer
//
//  Created by Thongpak on 4/10/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "HistoryCollectionViewCell"
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
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
