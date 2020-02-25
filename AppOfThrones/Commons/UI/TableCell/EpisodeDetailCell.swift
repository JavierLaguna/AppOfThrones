//
//  EpisodeDetailCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class EpisodeDetailCell: UITableViewCell, NibLoadableView, ReusableView {

    // MARK: IBOutlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var episodeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: Public functions
    
    func setEpisode(_ episode: Episode) {
        nameLabel.text = episode.name
        episodeLabel.text = "Episodio \(episode.episode) - Temporada \(episode.season)"
        dateLabel.text = episode.date
        descriptionLabel.text = episode.overview
    }
}
