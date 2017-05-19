//
//  HistoryDetailSectionController.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit

class HistoryDetailSectionController: ListSectionController, ListSupplementaryViewSource {
    var object: HistoryModel!
    
    override func numberOfItems() -> Int {
        return object.detail.count
    }
    
    override init() {
        super.init()
        supplementaryViewSource = self
        inset.top = 10
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width - 20, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: HistoryCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! HistoryCollectionViewCell
        cell.totalLabel.text = object.detail[index].amount?.toString
        cell.totalLabel.textColor = UIColor.blackAlpha()
        cell.dateLabel.text = object.detail[index].name
        cell.unitLabel.text = object.detail[index].price?.toString
        return cell
    }
    
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: self, nibName: HistoryDetailHeaderCollectionViewCell.identifier, bundle: nil, at: index) as! HistoryDetailHeaderCollectionViewCell
        view.priceLabel.text = object.totalPrice?.toString
        view.timeLabel.text = (object?.date)! + " at " + (object?.time)!
        return view
    }
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 45)
    }
    
    
    override func didUpdate(to object: Any) {
        self.object = object as? HistoryModel
    }
    
    override func didSelectItem(at index: Int) {
    }
}
