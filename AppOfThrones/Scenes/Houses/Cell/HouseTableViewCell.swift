//
//  HouseTableViewCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class HouseTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var houseImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var wordsButton: UIButton!
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    // MARK: Public functions

    func setHouse(_ house: House) {
        houseImage.image = UIImage(named: house.imageName ?? "")
        nameLabel.text = house.name
    }
    
    // MARK: Private functions
    
    private func configureView() {
        houseImage.layer.cornerRadius = 1.0
        houseImage.layer.borderWidth = 1.0
        houseImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
}
