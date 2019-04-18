//
//  UIViewController+Background.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/18/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setBackground(with image: String) {
        let backgroundImageView = UIImageView(image: UIImage(named: image))
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
}
