//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var rateButton: UIButton!
    
    // MARK: Variables
    
    var episodes: [Episode] = [Episode(id: 1, name: "Winter is Coming", date: "April 17, 2011", image: "episodeTest", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert...")]
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
}

// MARK: Private functions

private extension EpisodeViewController {
    
    func configureView() {
        title = "Seasons"
        
        rateButton.layer.cornerRadius = 4.0
    }
}

// MARK: IBActions

private extension EpisodeViewController {
    
    @IBAction func openRate(_ sender: Any) {
        let rateVC = RateViewController()
        present(rateVC, animated: true, completion: nil)
    }
}
