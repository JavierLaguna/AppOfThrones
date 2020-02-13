//
//  RateViewController.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 11/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
}

// MARK: Private functions

private extension RateViewController {
    
    func configureView() {
        confirmButton.layer.cornerRadius = 4.0
    }
}

// MARK: IBActions

private extension RateViewController {
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapButton(_ sender: Any) {
        tapCloseButton(sender)
    }
}
