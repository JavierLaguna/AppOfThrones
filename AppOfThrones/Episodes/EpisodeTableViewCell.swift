//
//  EpisodeTableViewCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 17/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var thumbImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var rateButton: UIButton!
    
    // MARK: LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    // MARK: Public functions

    func setEpisode(_ episode: Episode) {
        thumbImage.image = UIImage(named: episode.image ?? "")
        titleLabel.text = episode.name
        dateLabel.text = episode.date
    }
    
    // MARK: Private functions
    
    private func configureView() {
        thumbImage.layer.cornerRadius = 1.0
        thumbImage.layer.borderWidth = 1.0
        thumbImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        rateButton.layer.cornerRadius = 15
    }
}
