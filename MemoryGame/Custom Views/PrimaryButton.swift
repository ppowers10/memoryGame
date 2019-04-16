//
//  PrimaryButton.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
  
    var borderWidth: CGFloat = 1.0
    var borderColor: CGColor = UIColor.black.cgColor
    var buttonCornerRadius: CGFloat = 10.0
    
    var buttonTitle: String? {
        didSet {
            self.setTitle(buttonTitle, for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
            setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        setup()
    }

    private func setup() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.cornerRadius = buttonCornerRadius
        clipsToBounds = true
        super.layoutSubviews()
    }

}
