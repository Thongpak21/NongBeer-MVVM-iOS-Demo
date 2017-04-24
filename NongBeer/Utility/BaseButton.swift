//
//  BaseButton.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
@IBDesignable
class BaseButton: UIButton {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setButtonBorder()
    }
    
    func setButtonBorder() {
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }
    
    func setButtonNormal() {
        self.isEnabled = true
        self.setTitleColor(UIColor.blackAlpha(), for: .normal)
        self.setBackgroundColor(UIColor.primary(), forState: .normal)
        self.setBackgroundColor(UIColor.darkPrimary(), forState: .highlighted)
    }
    
    func disableButton() {
        self.isEnabled = false
        self.setBackgroundColor(UIColor.gray(), forState: .normal)
    }
    
    func setGhostButton() {
        self.isEnabled = true
        self.layer.borderWidth  = 1
        self.setBackgroundColor(UIColor.clear, forState: .normal)
        self.setTitleColor(UIColor.darkPrimary(), for: .normal)
        self.setBackgroundColor(UIColor.clear, forState: .highlighted)
        self.layer.borderColor = UIColor.darkPrimary().cgColor
    }

    func disableGhostButton() {
        self.isEnabled = false
        self.layer.borderColor = UIColor.gray().cgColor
    }
}
