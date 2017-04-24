//
//  ListBeerModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/10/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation
import IGListKit

class BeerModel: BaseModel {
    var alcohol: String?
    var image: String?
    var name: String?
    var price: Int?
    var volume: String?
    var id: String?
    var amount = 1
    var nextBeerIndex: Int?
    var isAddtoCart = false
    var nextBeerAvailable: Bool?
    var beerList = [BeerModel]()
    required init(withDictionary dict: AnyObject) {
        super.init(withDictionary: dict)
        if let data = dict["beers"] as? [[String: AnyObject]] {
            self.beerList = data.map({ BeerModel.init(withDictionary: $0 as AnyObject) })
        }
        self.alcohol = dict["alcohol"] as? String
        self.image = dict["image"] as? String
        self.name = dict["name"] as? String
        self.price = dict["price"] as? Int
        self.volume = dict["volume"] as? String
        self.id = dict["id"] as? String
        self.nextBeerAvailable = dict["nextBeerAvailable"] as? Bool
        self.nextBeerIndex = dict["nextBeerIndex"] as? Int
    }
}

extension BeerModel: IGListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}
