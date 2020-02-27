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
    
    var cast = [Cast]() {
        didSet {
            castTable.reloadData()
        }
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
        title = "Cast"
    }
    
    private func configureTable() {
        castTable.dataSource = self
        castTable.delegate = self
        
        castTable.register(UINib(nibName: CastTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CastTableViewCell.defaultReuseIdentifier)
        
        castTable.tableFooterView = UIView()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didFavoriteChanged), name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Constants.NotificationCenter.favoritesChanged, object: nil)
    }
    
    private func getData() {
        cast = DataController.shared.getCast()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actor = cast[indexPath.row]
        let detailVC = CastDetailViewController(withCast: actor)
        
        self.navigationController?.present(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
    }
}

// MARK: CastTableViewCellDelegate

extension CastViewController: FavoriteDelegate {
    
    @objc func didFavoriteChanged() {
        castTable.reloadData()
    }
}
