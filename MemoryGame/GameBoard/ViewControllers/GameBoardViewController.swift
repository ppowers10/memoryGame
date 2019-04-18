//
//  GameBoardViewController.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    // MARK: Variables
    
    var gameBoardSize: (Int, Int)?
    var cardTypeArray: [String] = []
    let possibleCards = ["memoryBatCardFront", "memoryCatCardFront", "memoryCowCardFront", "memoryDragonFront", "memoryGarbageManCardFront", "memoryGhostDogCardFront", "memoryHenCardFront", "memoryHorseCardFront", "memoryPigCardFront", "memorySpiderCardFront"]
    
    // MARK: Outlets
    
    @IBOutlet weak var cardVerticalStackView: UIStackView!
    
    
    // MARK: Lifecycle Events

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupBackButton()
        setupGrid()
    }
    

    // MARK: UI Setup
    
    private func setupLabels() {
        guard let gameBoardSize = gameBoardSize else {
            presentError()
            navigationController?.popViewController(animated: true)
            return
        }
        
        title = "\(gameBoardSize.0) x \(gameBoardSize.1)"
    }
    
    private func setupBackButton() {
        navigationItem.setHidesBackButton(true, animated:false)
        
        let backArrowImageView = BackArrow(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
        backArrowImageView.delegate = self
        backArrowImageView.alpha = 0.0
        navigationController?.view.addSubview(backArrowImageView)
        
        UIView.animate(withDuration: 0.8) {
            backArrowImageView.alpha = 1.0
        }
        
    }
    
    private func setupGrid() {
        
        guard let gameBoardSize = gameBoardSize else { return }
        
        cardVerticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let (columns, rows) = gameBoardSize
        var cardNumber = 0
        
        for _ in 1...rows {
            let horizontalStackView = createHorizontalStackView()
            cardVerticalStackView.addArrangedSubview(horizontalStackView)
            for _ in 1...columns {
                let cardDownImage = Card(frame: .zero)
                cardDownImage.delegate = self
                cardDownImage.tag = cardNumber
                horizontalStackView.addArrangedSubview(cardDownImage)
                cardNumber += 1
            }
        }
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 10.0
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }
    
    private func presentError() {
        let alert = UIAlertController(title: "Sorry", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Darn", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}

extension GameBoardViewController: BackArrowTap {
    
    func handleBackArrowTap(sender: UIImageView) {
        sender.removeFromSuperview()
        navigationController?.popViewController(animated: true)
    }
    
}

extension GameBoardViewController: CardTap {
    
    func handleCardTap(sender: UIImageView) {
        print("Card Tapped with tag: \(sender.tag)")
    }
    
}
