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
    @IBOutlet private weak var bigHeartImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var wordsButton: UIButton!
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: Variables
    
    private var house: House?
    private var isFavorite = false
    private var displayMode: DisplayMode = .words {
        didSet {
            displayModeHasChange()
        }
    }
    
    // MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
        addGestures()
    }
    
    // MARK: Public functions
    
    func setHouse(_ house: House) {
        self.house = house
        self.isFavorite = DataController.shared.isFavorite(house)
        
        houseImage.image = UIImage(named: house.imageName ?? "")
        nameLabel.text = house.name
        
        setFavoriteButton(isFavorite: isFavorite)
        displayModeHasChange()
    }
    
    // MARK: Private functions
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dobleTapImage))
        tap.numberOfTapsRequired = 2
        houseImage.isUserInteractionEnabled = true
        houseImage.addGestureRecognizer(tap)
    }
    
    private func configureView() {
        houseImage.layer.cornerRadius = 1.0
        houseImage.layer.borderWidth = 1.0
        houseImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        bigHeartImage.alpha = 0
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
    
    private func setFavoriteButton(isFavorite: Bool) {
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
    }
    
    private func animateFavorite(isFavorite: Bool) {
        setFavoriteButton(isFavorite: isFavorite)
        
        let image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        bigHeartImage.image = image
        bigHeartImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            
            self?.bigHeartImage.alpha = 1
            self?.bigHeartImage.transform = .identity
            
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: 0.4, animations: { [weak self] in
                    self?.bigHeartImage.alpha = 0
                })
        })
    }
    
    private func toogleFavorite() {
        guard let house = house else { return }
        
        let favorite = !isFavorite
        animateFavorite(isFavorite: favorite)
        DataController.shared.toogleFavorite(house)
        
        self.isFavorite = favorite
    }
    
    @objc private func dobleTapImage() {
        toogleFavorite()
    }
    
    // MARK: IBActions
    
    @IBAction private func tapFavoriteButton(_ sender: Any) {
        toogleFavorite()
    }
    
    @IBAction private func tapWordsButton(_ sender: Any) {
        displayMode = .words
    }
    
    @IBAction private func tapLocationButton(_ sender: Any) {
        displayMode = .location
    }
}
