//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 11/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

final class RateViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var confirmButton: UIButton!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: Private functions
    
    private func configureView() {
        confirmButton.layer.cornerRadius = 4.0
    }
    
    // MARK: IBActions
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapButton(_ sender: Any) {
        tapCloseButton(sender)
    }
}
