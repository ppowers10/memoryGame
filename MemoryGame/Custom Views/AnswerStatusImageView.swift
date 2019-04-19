//
//  AnswerStatusImageView.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/18/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

class AnswerStatusImageView: UIImageView {

    // MARK: Variables
    
    var isCorrect: Bool = false
    var incorrectImage = UIImage(named: "red_x")
    var correctImage = UIImage(named: "green_check")
    
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience init(frame: CGRect, isCorrect: Bool) {
        self.init(frame: frame)
        self.isCorrect = isCorrect
        setup()
    }
    
    
    // MARK: UI Setup
    
    private func setup() {
        if isCorrect {
            if let correctImage = correctImage {
                image = correctImage
            }
        } else {
            if let incorrectImage = incorrectImage {
                image = incorrectImage
            }
        }
                
        contentMode = .scaleAspectFit
    }
    
}
