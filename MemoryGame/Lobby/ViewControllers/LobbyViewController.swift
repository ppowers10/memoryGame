//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    // MARK: Variables
    
    var gameOptions: [(Int, Int)] = [ (3, 4), (5, 2), (4, 4), (4, 5) ]
    
    
    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pickGameLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    
    // MARK: Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupLabels()
        setupButtons()
    }
    
    
    // MARK: UI Setup
    
    private func setupLabels() {
        headerLabel.text = "Memory Game"
        pickGameLabel.text = "Pick Your Game Size"
    }
    
    private func setupButtons() {
        for (index, gameOption) in gameOptions.enumerated() {
            let gameOptionButton = PrimaryButton(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
            gameOptionButton.delegate = self
            let (x, y) = gameOption
            gameOptionButton.buttonTitle = "\(x) x \(y)"
            gameOptionButton.tag = index
            buttonStackView.addArrangedSubview(gameOptionButton)
        }
    }

}

extension LobbyViewController: PrimaryButtonTap {
    func handlePrimaryBUttonTap(sender: UIButton) {
        print("Button with tag \(sender.tag) tapped")
    }
}
