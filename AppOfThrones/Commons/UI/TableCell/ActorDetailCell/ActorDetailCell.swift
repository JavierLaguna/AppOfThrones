//
//  ActorDetailCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class ActorDetailCell: UITableViewCell, NibLoadableView, ReusableView  {
    
    // MARK: IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var birthLabel: UILabel!
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var episodesLabel: UILabel!
    
    // MARK: Public functions
    
    func setCast(_ cast: Cast) {
        nameLabel.text = cast.fullname
        roleLabel.text = cast.role
        birthLabel.text = cast.birth
        placeLabel.text = cast.placeBirth
        episodesLabel.text = "\(cast.episodes ?? 0) episodios"
    }
}
