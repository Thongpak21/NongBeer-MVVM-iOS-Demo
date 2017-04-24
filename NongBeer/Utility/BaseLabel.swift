//
//  BaseLabel.swift
//  NongBeer
//
//  Created by Thongpak on 4/14/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
@IBDesignable
class BaseLabel: UILabel {
    @IBInspectable var style: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        if let style = style {
            if style.lowercased() == "title" {
                self.setTitleLabel()
            } else if style.lowercased() == "body" {
                self.setBodyLabel()
            } else {
                self.setDescLabel()
            }
        }
    }
    
    func setTitleLabel() {
        self.font = font.withSize(20)
    }
    
    func setBodyLabel() {
        self.font = font.withSize(17)
    }
    
    func setDescLabel() {
        self.font = font.withSize(15)
    }
}
