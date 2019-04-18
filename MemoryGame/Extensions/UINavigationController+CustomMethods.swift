//
//  UINavigationController+Clear.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func setupClearNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    func setupNavigationTitleAttributes() {
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0),
             NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size: 45)!]
    }
}
