//
//  HouseTableViewCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 18/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

private enum DisplayMode {
    case words
    case location
}

final class HouseTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var houseImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var wordsButton: UIButton!
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: Variables
    
    private var house: House?
    private var displayMode: DisplayMode = .words {
        didSet {
            displayModeHasChange()
        }
    }
    
    // MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    // MARK: Public functions
    
    func setHouse(_ house: House) {
        self.house = house
        
        houseImage.image = UIImage(named: house.imageName ?? "")
        nameLabel.text = house.name
        
        displayModeHasChange()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        houseImage.layer.cornerRadius = 1.0
        houseImage.layer.borderWidth = 1.0
        houseImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    private func displayModeHasChange() {
        switch displayMode {
        case .words:
            descriptionLabel.text = house?.words
            wordsButton.setImage(UIImage(systemName: "quote.bubble.fill"), for: .normal)
            locationButton.setImage(UIImage(systemName: "location"), for: .normal)
        case .location:
            descriptionLabel.text = house?.seat
            wordsButton.setImage(UIImage(systemName: "quote.bubble"), for: .normal)
            locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        }
    }
    
    // MARK: IBActions
    
    @IBAction private func tapFavoriteButton(_ sender: Any) {
        
    }
    
    @IBAction private func tapWordsButton(_ sender: Any) {
        displayMode = .words
    }
    
    @IBAction private func tapLocationButton(_ sender: Any) {
        displayMode = .location
    }
}
