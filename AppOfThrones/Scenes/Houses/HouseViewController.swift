//
//  HouseViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class HouseViewController: UIViewController, TabBarItemable {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var housesTable: UITableView!
    
    // MARK: Variables
    
    var tbTitle: String { "Houses" }
    var tbImage: UIImage? { UIImage(systemName: "shield.lefthalf.fill") }
    private var houses = [House]() {
        didSet {
            housesTable.reloadData()
        }
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
        housesTable.dataSource = self
        housesTable.delegate = self
        
        housesTable.register(UINib(nibName: HouseTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HouseTableViewCell.defaultReuseIdentifier)
        
        housesTable.tableFooterView = UIView()
    }
    
    private func getData() {
        houses = DataController.shared.getHouses()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didFavoriteChanged), name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
    
    @objc private func didFavoriteChanged() {
        housesTable.reloadData()
    }
}

// MARK: UITableViewDataSource

extension HouseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HouseTableViewCell.defaultReuseIdentifier, for: indexPath) as? HouseTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setHouse(houses[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension HouseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
