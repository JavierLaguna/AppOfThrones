//
//  SettingsViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 13/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var favoritesView: UIView!
    @IBOutlet private weak var ratedView: UIView!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        addGestures()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        title = "Settings"
    }
    
    private func addGestures() {
        favoritesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emptyFavorites)))
        ratedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emptyRates)))
    }
    
    @objc private func emptyFavorites() {
        displayDeleteAdvice(title: "Borrar Favoritos") {
            DataController.shared.cleanFavorites()
        }
    }
    
    @objc private func emptyRates() {
        displayDeleteAdvice(title: "Borrar Favoritos") {
            DataController.shared.cleanRating()
        }
    }
    
    private func displayDeleteAdvice(title: String, onAccept: @escaping () -> Void) {
        let yesAction = UIAlertAction(title: "Borrar", style: .destructive, handler: { _ in
            onAccept()
        })
        let noAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: "La acción no podrá deshacerse", preferredStyle: .alert)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true)
    }
}
