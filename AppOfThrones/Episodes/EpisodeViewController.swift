//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class EpisodeViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var episodesTable: UITableView!
    
    // MARK: Variables
    
    var episodes: [Episode] = [Episode(id: 1, name: "Winter is Coming", date: "April 17, 2011", image: "episodeTest", episode: 1, season: 1, overview: "Jon Arryn, the Hand of the King, is dead. King Robert...")]
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        title = "Seasons"
    }
    
    private func configureTable() {
        episodesTable.dataSource = self
        episodesTable.delegate = self
        
        episodesTable.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
    }
    
    // MARK: IBActions
    
}

// MARK: UITableViewDataSource

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    

}

// MARK: UITableViewDelegate

extension EpisodeViewController: UITableViewDelegate {

}
