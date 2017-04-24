//
//  BaseProtocol.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation

public protocol BaseViewModelDelegate: class {
    
    // Load data
    
    func onDataDidLoad()
    func onDataDidLoadErrorWithMessage(errorMessage:String)
    
    // Loading
    func showLoading()
    func hideLoading()
}
