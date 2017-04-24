//
//  BaseViewModel.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import Foundation

public class BaseViewModel: NSObject {
    
    public weak var delegate: BaseViewModelDelegate?
    
    required public init(delegate: BaseViewModelDelegate) {
        self.delegate = delegate
    }
}
