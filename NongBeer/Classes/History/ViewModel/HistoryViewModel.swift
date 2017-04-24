//
//  HistoryViewModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation
import IGListKit
protocol HistoryViewModelProtocol {
    var history: [IGListDiffable] {get set}
    func getListHistoryService()
    func getListHistoryHandler() -> APIRequest.completionHandler
    var isPullToRefresh: Bool { get set }
}
class HistoryViewModel: BaseViewModel, HistoryViewModelProtocol {
    var history = [LoadingType.refresh.rawValue as IGListDiffable]
    var page: Int? = 0
    var isPullToRefresh = false
    func getListHistoryService() {
        
        let router = Router.getHistory(page: page!)
        _ = APIRequest.request(withRouter: router, withHandler: getListHistoryHandler())
    }
    
    func getListHistoryHandler() -> APIRequest.completionHandler {
        return { [weak self] (response, error) in
            if let response = response as? HistoryModel {
                self?.page = response.nextOrderIndex
                if self?.history.contains(where: { $0 as? String == LoadingType.refresh.rawValue }) == true {
                    self?.history.remove(at: 0)
                }
                
                if self?.history.contains(where: { $0 as? String == LoadingType.loadmore.rawValue }) == true {
                    self?.history.removeLast()
                }
                self?.history.append(response)
                self?.delegate?.onDataDidLoad()
            } else {
                
                self?.delegate?.onDataDidLoad()
            }
        }
    }
}
