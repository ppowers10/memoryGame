//
//  Card.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/17/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

protocol CardTap {
    func handleCardTap(sender: UIImageView)
}

class Card: UIImageView {

    // MARK: Variables
    
    var cardBackImage = UIImage(named: "allCardBacks")
    var delegate: CardTap?
    
    
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
        if let cardImage = cardBackImage {
            image = cardImage
        }
        
        isUserInteractionEnabled = true
        let cardImage = UITapGestureRecognizer(target: self, action: #selector(cardTap))
        addGestureRecognizer(cardImage)
        
        contentMode = .scaleAspectFit
        
    }
    
    
    // MARK: Delegate Callback
    
    @objc private func cardTap() {
        delegate?.handleCardTap(sender: self)
    }

}
