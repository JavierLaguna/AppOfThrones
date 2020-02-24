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
        getData(of: 1)
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
        
        episodesTable.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        
        episodesTable.tableFooterView = UIView()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        let episode = episodes[indexPath.row]
        cell.setEpisode(episode)
        cell.delegate = self
        cell.rateBlock = { [weak self] in
            let rateVC = UINavigationController(rootViewController: RateViewController(withEpisode: episode))
            self?.navigationController?.present(rateVC, animated: true, completion: nil)
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

// MARK: EpisodeTableViewCellDelegate

extension EpisodesViewController: EpisodeTableViewCellDelegate {
    
    func didFavoriteChanged() {
        episodesTable.reloadData()
    }
}
