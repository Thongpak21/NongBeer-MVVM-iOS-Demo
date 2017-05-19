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
class OrderListSectionViewController: ListSectionController {
    var object: BeerModel?
    var amount: Int?
    override func numberOfItems() -> Int {
        return 1
    }
    weak var delegate: OrderListSectionViewControllerDelegate?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width - 10, height: 120)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: OrderListCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! OrderListCollectionViewCell
        cell.beerLabel.text = object?.name
        cell.priceLabel.text = object?.price?.toString
        cell.amountLabel.text = object?.amount.toString
        
        cell.delegate = self
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? BeerModel
        self.amount = self.object?.amount
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}

extension OrderListSectionViewController: OrderListCollectionViewCellDelegate {
    func updateAmount(amount: Int, cell: UICollectionViewCell) {
        self.object?.amount = amount
        collectionContext?.performBatch(animated: true, updates: { (context) in
            context.reload(self)
        }, completion: nil)
        delegate?.updateAmount()
    }

    func removeOrder(cell: UICollectionViewCell) {
        let section = collectionContext?.index(for: cell, sectionController: self)
        delegate?.removeOrder(id: (object?.id)!, section: section!)
    }
}
