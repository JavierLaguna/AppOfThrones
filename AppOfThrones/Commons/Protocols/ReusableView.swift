//
//  ReusableView.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 24/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
