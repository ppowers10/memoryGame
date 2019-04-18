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
    var borderColor: CGColor = UIColor(red:0.80, green:0.50, blue:0.03, alpha:1.0).cgColor
    var fillColor: CGColor = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0).cgColor
    var buttonCornerRadius: CGFloat = 10.0
    weak var delegate: PrimaryButtonTap?
    
    var buttonTitle: String? {
        didSet {
            self.setTitle(buttonTitle, for: .normal)
            self.setTitleColor(UIColor.white, for: .normal)
            setTitleColor(UIColor.white.withAlphaComponent(0.2), for: .highlighted)
            titleLabel?.font = UIFont(name: "ChalkboardSE-Regular", size: 30)!
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
