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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func tapButton(_ sender: Any) {
        print("tap")
    }
}
