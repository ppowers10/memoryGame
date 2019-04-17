//
//  PrimaryButton.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

protocol PrimaryButtonTap {
    func handlePrimaryBUttonTap(sender: UIButton)
}

class PrimaryButton: UIButton {
  
    // MARK: Variables
    
    var borderWidth: CGFloat = 1.0
    var borderColor: CGColor = UIColor.black.cgColor
    var buttonCornerRadius: CGFloat = 10.0
    var delegate: PrimaryButtonTap?
    
    var buttonTitle: String? {
        didSet {
            self.setTitle(buttonTitle, for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
            setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
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
