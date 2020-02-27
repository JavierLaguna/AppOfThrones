//
//  EpisodeTableViewCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 17/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol EpisodeTableViewCellDelegate: AnyObject {
    func didFavoriteChanged()
}

final class EpisodeTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var thumbImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var rateButton: UIButton!
    @IBOutlet private weak var starsStack: UIStackView!
    @IBOutlet private weak var stars01: UIImageView!
    @IBOutlet private weak var stars02: UIImageView!
    @IBOutlet private weak var stars03: UIImageView!
    @IBOutlet private weak var stars04: UIImageView!
    @IBOutlet private weak var stars05: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: Variables
    
    weak var delegate: EpisodeTableViewCellDelegate?
    var episode: Episode?
    var rateBlock: (() -> Void)?
    
    // MARK: LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    // MARK: Public functions

    func setEpisode(_ episode: Episode) {
        self.episode = episode
        
        let heartImagaNamed = DataController.shared.isFavorite(episode) ? "heart.fill" : "heart"
        
        favoriteButton.setImage(UIImage(systemName: heartImagaNamed), for: .normal)
        
        thumbImage.image = UIImage(named: episode.image ?? "")
        titleLabel.text = episode.name
        dateLabel.text = episode.date
        
        let rating = DataController.shared.ratingForEpisode(episode)
        modeRated(rating != nil)
        if let rate = rating?.rate {
            switch rate {
            case .rated(value: let rateValue):
                modeRated(true)
                setRating(rateValue)
            default:
                modeRated(false)
            }
        }
    }
    
    // MARK: Private functions
    
    private func configureView() {
        thumbImage.layer.cornerRadius = 1.0
        thumbImage.layer.borderWidth = 1.0
        thumbImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        rateButton.layer.cornerRadius = 15
    }
    
    private func modeRated(_ isRated: Bool) {
        rateButton.isHidden = isRated
        starsStack.isHidden = !isRated
    }
    
    private func setRating(_ rating: Double) {
        setStarImage(stars01, rating: rating, position: 0)
        setStarImage(stars02, rating: rating, position: 1)
        setStarImage(stars03, rating: rating, position: 2)
        setStarImage(stars04, rating: rating, position: 3)
        setStarImage(stars05, rating: rating, position: 4)
    }
    
    private func setStarImage(_ imageView: UIImageView, rating: Double, position: Int) {
        let positionDouble = Double(position * 2)
        
        if rating >= positionDouble + 1 && rating < positionDouble + 2 {
            imageView.image = UIImage(systemName: "star.lefthalf.fill")
        } else if rating >= positionDouble + 2 {
            imageView.image = UIImage(systemName: "star.fill")
        } else {
            imageView.image = UIImage(systemName: "star")
        }
    }
    
    // MARK: IBActions

    @IBAction private func tapRateButton(_ sender: Any) {
        rateBlock?()
    }
    
    @IBAction private func tapFavoriteButton(_ sender: Any) {
        guard let episode = episode else {
            return
        }
        
        DataController.shared.toogleFavorite(episode)
        delegate?.didFavoriteChanged()
    }
}
