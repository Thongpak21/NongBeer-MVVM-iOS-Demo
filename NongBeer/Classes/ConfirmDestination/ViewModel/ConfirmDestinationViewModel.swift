//
//  ConfirmDestinationViewModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/13/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import CoreLocation
class ConfirmDestinationViewModel: BaseViewModel {
    func requestOrderService(order: Array<Any>, location: CLLocationCoordinate2D) {
        self.delegate?.showLoading()
        let router = Router.addNewOrder(latitude: location.latitude.toString, longitude: location.longitude.toString, beers: order)
        _ = APIRequest.request(withRouter: router, withHandler: requestOrderHandler())
    }
    
    func requestOrderHandler() -> APIRequest.completionHandler {
        return { [weak self] (response, error) in
            if let response = response as? BaseModel {
                self?.delegate?.hideLoading()
                self?.delegate?.onDataDidLoad()
            } else {
//                self?.delegate?.onDataDidLoad()
            }
        }
    }

}
