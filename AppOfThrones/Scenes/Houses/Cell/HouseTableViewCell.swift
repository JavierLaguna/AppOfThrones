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

    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    // MARK: Public functions

    func setHouse(_ house: House) {
        houseImage.image = UIImage(named: house.imageName ?? "")
        nameLabel.text = house.name
        seatLabel.text = house.seat
        wordsLabel.text = house.words
    }
    
    // MARK: Private functions
    
    private func configureView() {
        houseImage.layer.cornerRadius = 1.0
        houseImage.layer.borderWidth = 1.0
        houseImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
}
