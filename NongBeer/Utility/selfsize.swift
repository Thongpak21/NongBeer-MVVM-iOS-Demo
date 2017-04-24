//
//  selfsize.swift
//  NongBeer
//
//  Created by Thongpak on 4/15/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit

protocol SelfSizingCell {
    associatedtype ItemType: IGListDiffable
    var item: ItemType? { get set }
}

class SelfSizingCellSizeCache: NSObject {
    static let shared = SelfSizingCellSizeCache()
    
    private var cache = Dictionary<SizeCacheItemKey, CGFloat>()
    
    public func cacheCellSize<C: UICollectionViewCell>
        (forCell cell: C,
         item: IGListDiffable,
         forWidth: CGFloat,
         cellName: String) -> CGFloat
        where C: SelfSizingCell {
            let size = cell.contentView.systemLayoutSizeFitting(CGSize(width: forWidth, height: .greatestFiniteMagnitude))
            let itemKey = SizeCacheItemKey(item: item, forWidth: forWidth, cellName: cellName)
            cache[itemKey] = size.height
            return size.height
    }
    
    public func cellHeight(forItem item: IGListDiffable,
                           forWidth: CGFloat,
                           cellName: String) -> CGFloat? {
        let itemKey = SizeCacheItemKey(item: item, forWidth: forWidth, cellName: cellName)
        
        guard let index = cache.index(forKey: itemKey) else {
            return nil
        }
        
        return cache[index].value
    }
}

fileprivate struct SizeCacheItemKey {
    let item: IGListDiffable
    let forWidth: CGFloat
    let cellName: String
}

extension SizeCacheItemKey: Hashable {
    var hashValue: Int {
        let value = item.diffIdentifier().hash ^ forWidth.hashValue ^ cellName.hashValue
        return value
    }
}

fileprivate func ==(lhs: SizeCacheItemKey, rhs: SizeCacheItemKey) -> Bool {
    return lhs.item.isEqual(toDiffableObject: rhs.item) &&
        lhs.forWidth == rhs.forWidth &&
        lhs.cellName == rhs.cellName
}

extension SelfSizingCell
where Self: UICollectionViewCell {
    static func heightForSelfSizingCell(item: ItemType, width: CGFloat) -> CGFloat {
        let cellName = String(describing: self)
        if let height = SelfSizingCellSizeCache.shared.cellHeight(forItem: item, forWidth: width, cellName: cellName) {
            return height
        }
        
        guard var cell = self.cellForMeasuringCellOnly() as? Self else {
            assertionFailure("Unable to load cell")
            return 0
        }
        cell.item = item
        return SelfSizingCellSizeCache.shared.cacheCellSize(forCell: cell, item: item, forWidth: width, cellName: cellName)
    }
}
