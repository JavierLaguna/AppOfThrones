//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    // MARK: Variables
    var episodes: [Episode] = [Episode(id: 1, name: "Winter is Coming", date: "April 17, 2011", image: "episodeTest", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert...")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openRate(_ sender: Any) {
        
    }
}
