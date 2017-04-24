//
//  OrderListViewModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/14/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
protocol OrderListViewModelProtocol {
    var order: [BeerModel] { get set }
    func totalPrice() -> String
}
class OrderListViewModel: BaseViewModel, OrderListViewModelProtocol {
    var order = [BeerModel]()
    
    func totalPrice() -> String {
        let total = order.flatMap({ $0.price! * $0.amount }).reduce(0, +)
        let numberFormat = NumberFormatter.localizedString(from: total as NSNumber, number: .decimal)
        return numberFormat
    }
}
