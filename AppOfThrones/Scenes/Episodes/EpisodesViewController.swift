//
//  EpisodeViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class EpisodesViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var episodesSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var episodesTable: UITableView!
    
    // MARK: Variables
    
    var episodes = [Episode]()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
        addObservers()
        getData(of: 1)
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        title = "Seasons"
        
        episodesSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.orangeMain], for: .normal)
        episodesSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        episodesSegmentedControl.selectedSegmentTintColor = .orangeMain;
    }
    
    private func configureTable() {
        episodesTable.dataSource = self
        episodesTable.delegate = self
        
        episodesTable.register(UINib(nibName: EpisodeTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: EpisodeTableViewCell.defaultReuseIdentifier)
        
        episodesTable.tableFooterView = UIView()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didFavoriteChanged), name: Constants.NotificationCenter.favoritesChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onRateChanged), name: Constants.NotificationCenter.ratesChanged, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Constants.NotificationCenter.favoritesChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: Constants.NotificationCenter.ratesChanged, object: nil)
    }
    
    private func getData(of seasonNumber: Int) {
        let season = "season_\(seasonNumber)"
        guard let pathURL = Bundle.main.url(forResource: season, withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: pathURL)
            let decoder = JSONDecoder()
            episodes = try decoder.decode([Episode].self, from: data)
            episodesTable.reloadData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @objc private func onRateChanged() {
        episodesTable.reloadData()
    }
    
    // MARK: IBActions
    
    @IBAction private func onChangeSeason(_ sender: UISegmentedControl) {
        getData(of: sender.selectedSegmentIndex + 1)
    }
}

// MARK: UITableViewDataSource

extension EpisodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.defaultReuseIdentifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        let episode = episodes[indexPath.row]
        cell.setEpisode(episode)
        cell.delegate = self
        cell.rateBlock = { [weak self] in
            let rateVC = RateViewController(withEpisode: episode)
            rateVC.onRate = self?.onRateChanged
            self?.navigationController?.present(UINavigationController(rootViewController: rateVC), animated: true, completion: nil)
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        
        let detailVC = EpisodeDetailViewController(withEpisode: episode)
        self.navigationController?.present(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
    }
}

// MARK: EpisodeTableViewCellDelegate

extension EpisodesViewController: EpisodeTableViewCellDelegate {
    
    @objc func didFavoriteChanged() {
        episodesTable.reloadData()
    }
}

