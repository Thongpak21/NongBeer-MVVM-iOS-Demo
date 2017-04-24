//
//  SpinnerCollectionViewCell.swift
//  NongBeer
//
//  Created by Thongpak on 4/11/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    static let identifier = "LoadingCollectionViewCell"
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        spinner.startAnimating()
    }
}
