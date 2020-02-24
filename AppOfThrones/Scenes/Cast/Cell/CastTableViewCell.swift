//
//  CastTableViewCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 17/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol CastTableViewCellDelegate: AnyObject {
    func didFavoriteChanged()
}

final class CastTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: Variables
    
    weak var delegate: CastTableViewCellDelegate?
    var cast: Cast?
    
    // MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    // MARK: Public functions
    
    func setCast(_ cast: Cast) {
        self.cast = cast
        
        let heartImagaNamed = DataController.shared.isFavoriteCast(cast) ? "heart.fill" : "heart"
        
        favoriteButton.setImage(UIImage(systemName: heartImagaNamed), for: .normal)
        avatarImage.image = UIImage(named: cast.avatar ?? "")
        nameLabel.text = cast.fullname
        roleLabel.text = cast.role
    }
    
    // MARK: Private functions
    
    private func configureView() {
        avatarImage.layer.cornerRadius = 8
        avatarImage.layer.borderWidth = 1.0
        avatarImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    // MARK: IBActions
    
    @IBAction private func tapFavoriteButton(_ sender: Any) {
        guard let cast = cast else {
            return
        }
        
        DataController.shared.toogleFavorite(cast)
        delegate?.didFavoriteChanged()
    }
}
