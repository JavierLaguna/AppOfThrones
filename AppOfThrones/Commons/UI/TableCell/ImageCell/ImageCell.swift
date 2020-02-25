//
//  ImageCell.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class ImageCell: UITableViewCell, NibLoadableView, ReusableView {
    
    // MARK: IBOutlet

    @IBOutlet private weak var episodeImage: UIImageView!
    
    // MARK: Public func
    
    func setImage(_ image: UIImage?) {
        episodeImage.image = image
    }
    
}
