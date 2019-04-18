//
//  String+NSLocalizedStringShort.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/18/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
