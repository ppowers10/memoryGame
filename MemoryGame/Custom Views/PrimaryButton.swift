//
//  PrimaryButton.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

protocol PrimaryButtonTap: class {
    func handlePrimaryBUttonTap(sender: UIButton)
}

class PrimaryButton: UIButton {
  
    // MARK: Variables
    
    var borderWidth: CGFloat = 1.0
    var borderColor: CGColor = Styles.Color.headerOrange.cgColor
    var fillColor: CGColor = Styles.Color.buttonFillOrange.cgColor
    var buttonCornerRadius: CGFloat = 10.0
    weak var delegate: PrimaryButtonTap?
    
    var buttonTitle: String? {
        didSet {
            self.setTitle(buttonTitle, for: .normal)
            self.setTitleColor(Styles.Color.buttonTitleWhite, for: .normal)
            setTitleColor(Styles.Color.buttonTitleHighlightedWhite, for: .highlighted)
            titleLabel?.font = Styles.Font.medium
        }
    }

    
    // MARK: Init
    
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

    
    // MARK: UI Setup
    
    private func setup() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        layer.backgroundColor = fillColor
        layer.cornerRadius = buttonCornerRadius
        clipsToBounds = true
        super.layoutSubviews()
        
        addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    
    // MARK: Delegate Callback
    
    @objc private func buttonTap() {
        delegate?.handlePrimaryBUttonTap(sender: self)
    }

}
