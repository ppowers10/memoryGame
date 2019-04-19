//
//  BackArrow.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

protocol BackArrowTap: class {
    func handleBackArrowTap(sender: UIImageView)
}

class BackArrow: UIImageView {
    
    // MARK: Variables
    
    var arrowImage = UIImage(named: "backNavButton")
    weak var delegate: BackArrowTap?
    
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: UI Setup
    
    private func setup() {
        if let arrowImage = arrowImage {
            image = arrowImage
        }
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(arrowTap))
        isUserInteractionEnabled = true
        addGestureRecognizer(backTap)
    }
    
    
    // MARK: Delegate Callback
    
    @objc private func arrowTap() {
        delegate?.handleBackArrowTap(sender: self)
    }
    
}
