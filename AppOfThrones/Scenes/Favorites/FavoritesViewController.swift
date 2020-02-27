//
//  FavoritesViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var favoritesTable: UITableView!
    
    // MARK: Variables
    
    var allEpisodes = [Episode]() {
        didSet {
            favoritesTable.reloadData()
        }
    }
    var favoriteEpisodes: [Episode] {
        return allEpisodes.filter { DataController.shared.isFavorite($0) }
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
        addObservers()
        getData()
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        title = "Favorites"
    }
    
    private func configureTable() {
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        
        favoritesTable.register(UINib(nibName: EpisodeTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: EpisodeTableViewCell.defaultReuseIdentifier)
        
        favoritesTable.tableFooterView = UIView()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didFavoriteChanged), name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
    
    private func getData() {
        allEpisodes = DataController.shared.getAllEpisodes()
    }
    
}

// MARK: UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.defaultReuseIdentifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        let episode = favoriteEpisodes[indexPath.row]
        cell.setEpisode(episode)
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = favoriteEpisodes[indexPath.row]
        let detailVC = EpisodeDetailViewController(withEpisode: episode)
        
        self.navigationController?.present(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
    }
}

// MARK: EpisodeTableViewCellDelegate

extension FavoritesViewController: EpisodeTableViewCellDelegate {
    
    @objc func didFavoriteChanged() {
        favoritesTable.reloadData()
    }
}
