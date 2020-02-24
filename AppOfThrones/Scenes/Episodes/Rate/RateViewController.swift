//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 11/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class RateViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var episodeImage: UIImageView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var star01: UIImageView!
    @IBOutlet private weak var star02: UIImageView!
    @IBOutlet private weak var star03: UIImageView!
    @IBOutlet private weak var star04: UIImageView!
    @IBOutlet private weak var star05: UIImageView!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var rateSlider: UISlider!
    
    // MARK: Variable
    
    private var episode: Episode?
    var onRate: (() -> Void)?
    
    // MARK: Constructor
    
    convenience init(withEpisode episode: Episode) {
        self.init()
        
        self.episode = episode
    }
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setEpisodeInfo()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        confirmButton.layer.cornerRadius = 4.0
    }
    
    private func setEpisodeInfo() {
        guard let episode = episode else { return }
        
        title = episode.name
        episodeImage.image = UIImage(named: episode.image ?? "")
        
        let rating = DataController.shared.ratingForEpisode(episode)
        switch rating?.rate {
        case .rated(let value):
            setRating(value)
        default:
            setRating(0)
        }
    }
    
    private func setRating(_ rating: Double) {
        rateLabel.text = String(Int(rating))
        
        setStarImage(star01, rating: rating, position: 0)
        setStarImage(star02, rating: rating, position: 1)
        setStarImage(star03, rating: rating, position: 2)
        setStarImage(star04, rating: rating, position: 3)
        setStarImage(star05, rating: rating, position: 4)
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
    
    @IBAction private func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func sliderChange(_ sender: Any) {
        let rate = Double(Int(rateSlider.value * 5) / 10)
        setRating(rate)
    }
    
    @IBAction private func tapConfirmButton(_ sender: Any) {
        let rate = Double(Int(rateSlider.value * 5) / 10)
        if let episode = self.episode {
            DataController.shared.rateEpisode(episode, value: rate)
            onRate?()
        }
        
        tapCloseButton(sender)
    }
}
