//
//  OrderListCollectionViewCell.swift
//  NongBeer
//
//  Created by Thongpak on 4/7/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
protocol OrderListCollectionViewCellDelegate: class {
    func removeOrder(cell: UICollectionViewCell)
    func updateAmount(amount: Int, cell: UICollectionViewCell)
}
class OrderListCollectionViewCell: UICollectionViewCell {
    static let identifier = "OrderListCollectionViewCell"
    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var removeOrderButton: UIButton!
    weak var delegate: OrderListCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        decreaseButton.addTarget(self, action: #selector(tapDecrease), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(tapIncrease), for: .touchUpInside)
        removeOrderButton.addTarget(self, action: #selector(tapRemoveOrder), for: .touchUpInside)
    }
    
    func tapRemoveOrder() {
        delegate?.removeOrder(cell: self)
    }
    
    func tapIncrease() {
        let amount = amountLabel.text!.toInt()! + 1
        delegate?.updateAmount(amount: amount, cell: self)
    }
    
    func tapDecrease() {
        if amountLabel.text!.toInt()! > 1 {
            let amount = amountLabel.text!.toInt()! - 1
            delegate?.updateAmount(amount: amount, cell: self)
        }
    }
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
