//
//  OrderListSectionController.swift
//  NongBeer
//
//  Created by Thongpak on 4/7/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit
protocol OrderListSectionViewControllerDelegate: class {
    func removeOrder(id: String, section: Int)
    func updateAmount()
}
class OrderListSectionViewController: IGListSectionController, IGListSectionType {
    var object: BeerModel?
    var amount: Int?
    func numberOfItems() -> Int {
        return 1
    }
    weak var delegate: OrderListSectionViewControllerDelegate?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width - 10, height: 120)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: OrderListCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! OrderListCollectionViewCell
        cell.beerLabel.text = object?.name
        cell.priceLabel.text = object?.price?.toString
        cell.amountLabel.text = object?.amount.toString
        
        cell.delegate = self
        return cell
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? BeerModel
        self.amount = self.object?.amount
    }
    
    func didSelectItem(at index: Int) {
        
    }
}

extension OrderListSectionViewController: OrderListCollectionViewCellDelegate {
    func updateAmount(amount: Int, cell: UICollectionViewCell) {
        self.object?.amount = amount
        collectionContext?.reload(self)
        delegate?.updateAmount()
    }

    func removeOrder(cell: UICollectionViewCell) {
        let section = collectionContext?.section(for: self)
        delegate?.removeOrder(id: (object?.id)!, section: section!)
    }
}
