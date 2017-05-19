//
//  SpinnerSectionController.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit

class LoadingSectionController: ListSectionController
{
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: LoadingCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! LoadingCollectionViewCell
        cell.spinner.startAnimating()
        return cell
    }
    
    override func didUpdate(to object: Any) {
    }
    
    override func didSelectItem(at index: Int) {
    }
}
