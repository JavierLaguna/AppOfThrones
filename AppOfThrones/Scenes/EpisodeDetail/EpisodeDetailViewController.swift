//
//  EpisodeDetailViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var episodeTable: UITableView!
    
    // MARK: Variables
    
    var episode: Episode?
    
    // MARK: LifeCycle
    
    convenience init(withEpisode episode: Episode) {
        self.init()
        
        self.episode = episode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    }
    
    
    // MARK: Private functions
    
    private func configureView() {
        title = episode?.name
    }
    
    private func configureTable() {
        episodeTable.dataSource = self
        episodeTable.delegate = self
        
        episodeTable.register(UINib(nibName: ImageCell.nibName, bundle: nil), forCellReuseIdentifier: ImageCell.defaultReuseIdentifier)
        
        episodeTable.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource

extension EpisodeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episode != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.defaultReuseIdentifier, for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }
        
        let episodeImage = UIImage(named: episode?.image ?? "")
        cell.setImage(episodeImage)
        return cell
    }
}

// MARK: UITableViewDelegate

extension EpisodeDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
