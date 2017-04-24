//
//  EmptyView.swift
//  NongBeer
//
//  Created by Thongpak on 4/8/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import EZSwiftExtensions
protocol EmptyViewDelegate: class {
    func didReload()
}
class EmptyView: UIView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    weak var delegate: EmptyViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        button.addTarget(self, action: #selector(tapReload), for: .touchUpInside)
        
    }

    func tapReload() {
        self.delegate?.didReload()
    }
}
