//
//  FirstSectionController.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit
import SDWebImage
enum LoadingType: String {
    case refresh, loadmore
}
protocol BeerSectionControllerDelegate: class {
    func addOrder(item: BeerModel?)
    func removeOrder(item: BeerModel?)
}
class BeerSectionController: ListSectionController {
    var object: BeerModel?
    override func numberOfItems() -> Int {
        return (object?.beerList.count)!
    }
    weak var delegate: BeerSectionControllerDelegate?
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        self.minimumInteritemSpacing = 6
        self.minimumLineSpacing = 8
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        let itemSize = ceil(width / 2)
        return CGSize(width: itemSize - 14, height: 200)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: BeerCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! BeerCollectionViewCell
        cell.beerLabel.text = object?.beerList[index].name
        cell.volumeLabel.text = object?.beerList[index].volume
        cell.alcoholLabel.text = object?.beerList[index].alcohol
        cell.priceLabel.text = object?.beerList[index].price?.toString
        cell.beerImage.sd_setImage(with: URL(string: (object?.beerList[index].image) ?? ""))
        cell.delegate = self
        if object?.beerList[index].isAddtoCart == true {
            cell.addButton.setGhostButton()
            cell.addButton.setTitle("Added", for: .normal)
        } else {
            cell.addButton.setButtonNormal()
            cell.addButton.setTitle("Add to order", for: .normal)
        }
    
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? BeerModel
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}

extension BeerSectionController: FirstCollectionViewCellDelegate {
    func didSelectAddButton(cell: UICollectionViewCell) {
        let index = collectionContext?.index(for: cell, sectionController: self)
        object?.beerList[index!].amount = 1
        if self.object?.beerList[index!].isAddtoCart == true {
            self.object?.beerList[index!].isAddtoCart = false
            self.delegate?.removeOrder(item: object?.beerList[index!])
        } else {
            self.object?.beerList[index!].isAddtoCart = true
            self.delegate?.addOrder(item: object?.beerList[index!])
        }
        collectionContext?.performBatch(animated: true, updates: { (context) in
            context.reload(in: self, at: IndexSet(integer: index!))
        }, completion: nil)
//        collectionContext?.reload(in: self, at: IndexSet(integer: index!))
    }
}
