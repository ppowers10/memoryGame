//
//  Styles.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/18/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

struct Styles {
    
    struct Font {
        static let large = UIFont(name: "ChalkboardSE-Regular", size: 45)!
        static let medium = UIFont(name: "ChalkboardSE-Regular", size: 38)!
    }
    
    struct Color {
        static let headerOrange = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
        static let buttonBorderOrange = UIColor(red:0.80, green:0.50, blue:0.03, alpha:1.0)
        static let buttonFillOrange = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
        static let buttonTitleWhite = UIColor.white
        static let buttonTitleHighlightedWhite = UIColor.white.withAlphaComponent(0.2)
    }
}
