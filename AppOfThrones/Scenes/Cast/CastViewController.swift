//
//  CastViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class CastViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var castTable: UITableView!
    
    // MARK: Variables
    
    var cast = [Cast]()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
        getData()
    }
    
    // MARK: Private functions
    
    private func configureTable() {
        castTable.dataSource = self
        castTable.delegate = self
        
        castTable.register(UINib(nibName: CastTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CastTableViewCell.defaultReuseIdentifier)
        
        castTable.tableFooterView = UIView()
    }
    
    private func getData() {
        guard let pathURL = Bundle.main.url(forResource: "cast", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: pathURL)
            let decoder = JSONDecoder()
            cast = try decoder.decode([Cast].self, from: data)
            castTable.reloadData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}

// MARK: UITableViewDataSource

extension CastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.defaultReuseIdentifier, for: indexPath) as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCast(cast[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate

extension CastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}


// MARK: CastTableViewCellDelegate


extension CastViewController: CastTableViewCellDelegate {
    
    func didFavoriteChanged() {
        castTable.reloadData()
    }
}
