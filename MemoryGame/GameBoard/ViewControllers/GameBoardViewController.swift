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
    let possibleCards: Set<String> = ["memoryBatCardFront", "memoryCatCardFront", "memoryCowCardFront", "memoryDragonFront", "memoryGarbageManCardFront", "memoryGhostDogCardFront", "memoryHenCardFront", "memoryHorseCardFront", "memoryPigCardFront", "memorySpiderCardFront"]
    var gameCards: [String] = []
    var cardOneSelected: Card?
    var matchesFound = 0
    
    // MARK: Outlets
    
    @IBOutlet weak var cardVerticalStackView: UIStackView!
    
    
    // MARK: Lifecycle Events

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLabels()
        setupBackButton()
        setupGrid()
        generateCards()
    }
    

    // MARK: UI Setup
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "farm_game_bg"))
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
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
    
    
    // MARK: Game Logic
    
    private func generateCards() {
        guard let gameBoardSize = gameBoardSize else { return }
        let cardPairsNeeded = (gameBoardSize.0 * gameBoardSize.1) / 2
        var copyPossibleCards = possibleCards
        for _ in 1...cardPairsNeeded {
            if let cardImage = copyPossibleCards.randomElement() {
                gameCards.append(cardImage)
                gameCards.append(cardImage)
                copyPossibleCards.remove(cardImage)
            }
        }
        gameCards.shuffle()
    }
    
    private func userGuess(with currentCard: Card) {
        let flipTransition: [UIView.AnimationOptions] = [.transitionFlipFromRight, .transitionFlipFromLeft, .transitionFlipFromTop, .transitionFlipFromBottom]
        UIView.transition(with: currentCard, duration: 0.3, options: flipTransition.randomElement() ?? .transitionFlipFromRight, animations: {
            if let updateImage = UIImage(named: self.gameCards[currentCard.tag]) {
                currentCard.image = updateImage
            }
        }) { (success) in
            currentCard.isUserInteractionEnabled = false
            
            guard let firstCardGuess = self.cardOneSelected else {
                self.cardOneSelected = currentCard
                return
            }
            
            if self.gameCards[firstCardGuess.tag] == self.gameCards[currentCard.tag] {
                // celebarte
                self.cardOneSelected = nil
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    firstCardGuess.image = UIImage(named: "allCardBacks")
                    firstCardGuess.isUserInteractionEnabled = true
                    currentCard.image = UIImage(named: "allCardBacks")
                    currentCard.isUserInteractionEnabled = true
                    
                    
                }
            }
            
            self.cardOneSelected = nil
        }
        
        
        
        
        
    }

}

extension GameBoardViewController: BackArrowTap {
    
    func handleBackArrowTap(sender: UIImageView) {
        sender.removeFromSuperview()
        navigationController?.popViewController(animated: true)
    }
    
}

extension GameBoardViewController: CardTap {
    
    func handleCardTap(sender: Card) {
        userGuess(with: sender)
    }
    
}
