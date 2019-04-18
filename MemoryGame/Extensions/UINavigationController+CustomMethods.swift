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
            [NSAttributedString.Key.foregroundColor: Styles.Color.headerOrange,
             NSAttributedString.Key.font: Styles.Font.large]
    }
    
}
