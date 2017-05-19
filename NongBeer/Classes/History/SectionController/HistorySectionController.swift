//
//  HistorySectionController.swift
//  NongBeer
//
//  Created by Thongpak on 4/10/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit

class HistorySectionController: ListSectionController {
    var object: HistoryModel?
    
    override func numberOfItems() -> Int {
        return (object?.listOrders.count)!
    }
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)

        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width - 20, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: HistoryCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! HistoryCollectionViewCell
        cell.dateLabel.text = (object?.listOrders[index].date)! + " at " + (object?.listOrders[index].time)!
        cell.unitLabel.text = (object?.listOrders[index].totalAmount?.toString)! + " bottles of beers."
        cell.totalLabel.text = object?.listOrders[index].totalPrice?.toString
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? HistoryModel
    }
    
    override func didSelectItem(at index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateVC(HistoryDetailViewController.self)
        vc?.object = [(self.object?.listOrders[index])!]
        self.viewController?.pushVC(vc!)
    }
}
