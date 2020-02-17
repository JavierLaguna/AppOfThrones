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
    
    var cast = [
        Cast(id: 1, avatar: "Emilia Clarke", fullName: "Emilia Clarke", role: "Daenerys Targaryen", espisode: 73, birth: "1986-10-23", placeBirth: "London, England UK"),
        Cast(id: 1, avatar: "Kit Harington", fullName: "Kit Harington", role: "Jon Snow", espisode: 73, birth: "1986-10-23", placeBirth: "London, England UK")]
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
    }
    
    // MARK: Private functions
    
    private func configureTable() {
        castTable.dataSource = self
        castTable.delegate = self
        
        castTable.register(UINib(nibName: "CastTableViewCell", bundle: nil), forCellReuseIdentifier: "CastTableViewCell")
        
        castTable.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource

extension CastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCast(cast[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension CastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}
