//
//  OrderSuccessViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/9/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
protocol OrderSuccessViewControllerDelegate: class {
    func reloadOrder()
}
class OrderSuccessViewController: BaseViewController {
    @IBOutlet weak var closeButton: BaseButton!
    weak var delegate: OrderSuccessViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.setButtonNormal()
        closeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.navigationItem.hidesBackButton = true
    }
    
    func didTapButton() {
        self.dismissVC(completion: {
            self.delegate?.reloadOrder()
        })
    }
}
