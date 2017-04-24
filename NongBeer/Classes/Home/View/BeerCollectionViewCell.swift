//
//  FirstCollectionViewCell.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
protocol FirstCollectionViewCellDelegate: class {
    func didSelectAddButton(cell: UICollectionViewCell)
}
class BeerCollectionViewCell: UICollectionViewCell {
    weak var delegate: FirstCollectionViewCellDelegate?
    static let identifier = "BeerCollectionViewCell"
    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var addButton: BaseButton!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addButton.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
    }
    
    func didSelect() {
        self.delegate?.didSelectAddButton(cell: self)
    }
}
