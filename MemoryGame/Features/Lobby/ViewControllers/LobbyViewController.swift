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
    
    @IBOutlet weak var pickGameLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    
    // MARK: Lifecycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationController?.setupClearNavigationBar()
        setupBackground()
        setupLabels()
        setupButtons()
    }
    
    
    // MARK: UI Setup
    
    private func setupBackground() {
        setBackground(with: "farm_lobby_bg")
    }
    
    private func setupLabels() {
        navigationController?.setupNavigationTitleAttributes()
        title = "ui.lobby.header".localized
        
        pickGameLabel.text = "ui.lobby.pickGameBoard".localized
        pickGameLabel.font = Styles.Font.medium
        pickGameLabel.textColor = Styles.Color.titleRed
    }
    
    private func setupButtons() {
        for (index, gameOption) in gameOptions.enumerated() {
            let gameOptionButton = PrimaryButton(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
            gameOptionButton.buttonTitle = "\(gameOption.0) x \(gameOption.1)"
            gameOptionButton.tag = index
            gameOptionButton.delegate = self
            buttonStackView.addArrangedSubview(gameOptionButton)
        }
    }

}


extension LobbyViewController: PrimaryButtonTap {
    
    func handlePrimaryBUttonTap(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let gameBoardViewController = storyboard.instantiateViewController(withIdentifier: "GameBoardViewController") as! GameBoardViewController
        gameBoardViewController.gameBoardSize = gameOptions[sender.tag]
        
        self.navigationController?.pushViewController(gameBoardViewController, animated: true)
    }
    
}
