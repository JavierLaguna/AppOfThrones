//
//  FavoritesViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController, TabBarItemable {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var favoritesTable: UITableView!
    
    // MARK: Variables
    
    var tbTitle: String { "Favorites" }
    var tbImage: UIImage? { UIImage(systemName: "heart.fill") }
    
    private var allEpisodes = [Episode]() {
        didSet {
            favoritesTable.reloadData()
        }
    }
    
    private var favoriteEpisodes: [Episode] {
        return allEpisodes.filter { DataController.shared.isFavorite($0) }
    }
    
    private var cast = [Cast]() {
        didSet {
            favoritesTable.reloadData()
        }
    }
    
    private var favoriteCast: [Cast] {
        return cast.filter { DataController.shared.isFavorite($0) }
    }
    
    private var houses = [House]() {
        didSet {
            favoritesTable.reloadData()
        }
    }
    
    private var favoriteHouses: [House] {
        return houses.filter { DataController.shared.isFavorite($0) }
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
        addObservers()
        getData()
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: Private functions
    
    private func configureTable() {
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        
        favoritesTable.register(UINib(nibName: EpisodeTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: EpisodeTableViewCell.defaultReuseIdentifier)
        favoritesTable.register(UINib(nibName: CastTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CastTableViewCell.defaultReuseIdentifier)
        favoritesTable.register(UINib(nibName: HouseTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HouseTableViewCell.defaultReuseIdentifier)
        
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
        cast = DataController.shared.getCast()
        houses = DataController.shared.getHouses()
    }
    
}

// MARK: UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return favoriteEpisodes.count
        case 1:
            return favoriteCast.count
        case 2:
            return favoriteHouses.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Episodes"
        case 1:
            return "Cast"
        case 2:
            return "Houses"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return getEpisodeCell(tableView, cellForRowAt: indexPath)
        case 1:
            return getCastCell(tableView, cellForRowAt: indexPath)
        case 2:
            return getHouseCell(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func getEpisodeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.defaultReuseIdentifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        let episode = favoriteEpisodes[indexPath.row]
        cell.setEpisode(episode, rateHidden: true)
        cell.delegate = self
        return cell
    }
    
    private func getCastCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.defaultReuseIdentifier, for: indexPath) as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        let cast = favoriteCast[indexPath.row]
        cell.setCast(cast)
        cell.delegate = self
        return cell
    }
    
    private func getHouseCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HouseTableViewCell.defaultReuseIdentifier, for: indexPath) as? HouseTableViewCell else {
            return UITableViewCell()
        }
        
        let house = favoriteHouses[indexPath.row]
        cell.setHouse(house)
        return cell
    }
}

// MARK: UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 128
        case 1:
            return 148
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.darkGray
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: -6, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = labelForHeader(section)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.orangeMain
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let episode = favoriteEpisodes[indexPath.row]
            let detailVC = EpisodeDetailViewController(withEpisode: episode)
            
            self.navigationController?.present(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
        case 1:
            let cast = favoriteCast[indexPath.row]
            let detailVC = CastDetailViewController(withCast: cast)
            
            self.navigationController?.present(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
        default:
            return
        }
    }
    
    private func labelForHeader(_ section: Int) -> String {
        switch section {
        case 0:
            return "Episodes"
        case 1:
            return "Cast"
        case 2:
            return "Houses"
        default:
            return ""
        }
    }
}

// MARK: EpisodeTableViewCellDelegate

extension FavoritesViewController: FavoriteDelegate {
    
    @objc func didFavoriteChanged() {
        favoritesTable.reloadData()
    }
}
