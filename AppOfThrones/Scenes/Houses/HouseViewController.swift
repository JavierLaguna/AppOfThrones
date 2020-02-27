//
//  HouseViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class HouseViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet private weak var housesTable: UITableView!
    
    // MARK: Variables
    
    var houses = [House]()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
        getData()
    }

    // MARK: Private functions
    
    private func configureView() {
        title = "Houses"
    }
    
    private func configureTable() {
        housesTable.dataSource = self
        housesTable.delegate = self
        
        housesTable.register(UINib(nibName: HouseTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: HouseTableViewCell.defaultReuseIdentifier)
        
        housesTable.tableFooterView = UIView()
    }
    
    private func getData() {
        houses = DataController.shared.getHouses()
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
        return 174
    }
}
