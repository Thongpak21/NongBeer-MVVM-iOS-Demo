//
//  FirstViewModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation
import IGListKit
import EZSwiftExtensions
protocol BeerViewModelProtocol {
    var listOrder: [BeerModel] {get set}
    var beer: [ListDiffable] {get set}
    func getListBeerService()
    func getListBeerHandler() -> APIRequest.completionHandler
}
class BeerViewModel: BaseViewModel, BeerViewModelProtocol {
    var page: Int? = 0
    var listOrder = [BeerModel]()
    var beer = [LoadingType.refresh.rawValue as ListDiffable]
    func getListBeerService() {
        let router = Router.getListBeer(page: page!)
        _ = APIRequest.request(withRouter: router, withHandler: getListBeerHandler())
    }
    
    func getListBeerHandler() -> APIRequest.completionHandler {
        return { [weak self] (response, error) in
            if let response = response as? BeerModel {
                self?.page = response.nextBeerIndex
                if self?.beer.contains(where: { $0 as? String == LoadingType.refresh.rawValue }) == true {
                    self?.beer.remove(at: 0)
                }
                if self?.beer.contains(where: { $0 as? String == LoadingType.loadmore.rawValue }) == true {
                    self?.beer.removeLast()
                }
                self?.beer.append(response)
                self?.delegate?.onDataDidLoad()
            } else {
                self?.delegate?.onDataDidLoad()
            }
        }
    }
}
