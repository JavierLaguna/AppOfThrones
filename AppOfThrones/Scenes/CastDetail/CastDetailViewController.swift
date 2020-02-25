//
//  CastDetailViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 25/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class CastDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var castDetailTable: UITableView!
    
    // MARK: Variables
    
    var cast: Cast?
    
    // MARK: LifeCycle
    
    convenience init(withCast cast: Cast) {
        self.init()
        
        self.cast = cast
        print(cast.description)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTable()
    }
    
    
    // MARK: Private functions
    
    private func configureView() {
        title = cast?.fullname
    }
    
    private func configureTable() {
        castDetailTable.dataSource = self
        castDetailTable.delegate = self
        
        castDetailTable.register(UINib(nibName: ImageCell.nibName, bundle: nil), forCellReuseIdentifier: ImageCell.defaultReuseIdentifier)
        castDetailTable.register(UINib(nibName: ActorDetailCell.nibName, bundle: nil), forCellReuseIdentifier: ActorDetailCell.defaultReuseIdentifier)
        
        castDetailTable.tableFooterView = UIView()
    }
    
}

// MARK: UITableViewDataSource

extension CastDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.row == 0 ?
            getImageCell(tableView, cellForRowAt: indexPath)
            : getActorDetailCell(tableView, cellForRowAt: indexPath)
    }
    
    private func getImageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.defaultReuseIdentifier, for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }
        
        let episodeImage = UIImage(named: cast?.avatar ?? "")
        cell.setImage(episodeImage)
        return cell
    }
    
    private func getActorDetailCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cast = cast, let cell = tableView.dequeueReusableCell(withIdentifier: ActorDetailCell.defaultReuseIdentifier, for: indexPath) as? ActorDetailCell else {
            return UITableViewCell()
        }
        
        cell.setCast(cast)
        return cell
    }
}

// MARK: UITableViewDelegate

extension CastDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
