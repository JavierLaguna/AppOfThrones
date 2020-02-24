//
//  NibLoadableView.swift
//  AppOfThrones
//
//  Created by Javier Laguna on 24/02/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
