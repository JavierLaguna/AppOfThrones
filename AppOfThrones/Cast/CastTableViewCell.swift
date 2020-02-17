//
//  CastTableViewCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 17/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class CastTableViewCell: UITableViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    // MARK: Public functions
    
    func setCast(_ cast: Cast) {
        avatarImage.image = UIImage(named: cast.avatar ?? "")
        nameLabel.text = cast.fullName
        roleLabel.text = cast.role
        episodesLabel.text = "\(cast.espisode ?? 0) episodes"
    }
    
    // MARK: Private functions

    private func configureView() {
        avatarImage.layer.cornerRadius = 8
        avatarImage.layer.borderWidth = 1.0
        avatarImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
}
