//
//  HistoryModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation
import IGListKit

class HistoryModel: BaseModel {
    var detail = [HistoryDetailModel]()
    var date: String?
    var time: String?
    var totalAmount: Int?
    var totalPrice: Int?
    var listOrders = [HistoryModel]()
    var id: String?
    var nextOrderAvailable: Bool?
    var nextOrderIndex: Int? = 0
    required init(withDictionary dict: AnyObject) {
        super.init(withDictionary: dict)
        if let listHistory = dict["orders"] as? [[String: AnyObject]] {
            self.listOrders = listHistory.map({ HistoryModel.init(withDictionary: $0 as AnyObject) })
        }
        self.id = dict["id"] as? String
        self.date = dict["date"] as? String
        self.time = dict["time"] as? String
        self.totalAmount = dict["totalAmount"] as? Int
        self.totalPrice = dict["totalPrice"] as? Int
        self.nextOrderAvailable = dict["nextOrderAvailable"] as? Bool
        self.nextOrderIndex = dict["nextOrderIndex"] as? Int
        if let detail = dict["beers"] as? [[String: AnyObject]] {
            self.detail = detail.map({ HistoryDetailModel.init(withDictionary: $0 as AnyObject) })
        }
    }
}

extension HistoryModel: IGListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}


class HistoryDetailModel: BaseModel {
    var amount: Int?
    var price: Int?
    var id: String?
    var image: String?
    var name: String?
    required init(withDictionary dict: AnyObject) {
        super.init(withDictionary: dict)
        self.amount = dict["amount"] as? Int
        self.price = dict["price"] as? Int
        self.id = dict["id"] as? String
        self.image = dict["image"] as? String
        self.name = dict["name"] as? String
    }
}

extension HistoryDetailModel: IGListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}
