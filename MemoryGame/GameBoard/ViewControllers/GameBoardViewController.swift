//
//  GameBoardViewController.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/16/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    // MARK: Constants
    
    struct K {
        static let fadeAnimationDuration = 0.8
        static let alphaTransparent: CGFloat = 0.0
        static let alphaOpaque: CGFloat = 1.0
        static let flipAnimationDuration = 0.3
        static let incorrectDelayTime = 1.0
        static let horizontalStackViewSpacing: CGFloat = 10.0
    }
    
    // MARK: Variables
    
    let possibleCards: Set<String> = ["memoryBatCardFront", "memoryCatCardFront", "memoryCowCardFront", "memoryDragonFront", "memoryGarbageManCardFront", "memoryGhostDogCardFront", "memoryHenCardFront", "memoryHorseCardFront", "memoryPigCardFront", "memorySpiderCardFront"]
    let flipTransition: [UIView.AnimationOptions] = [.transitionFlipFromRight, .transitionFlipFromLeft, .transitionFlipFromTop, .transitionFlipFromBottom]
    let backButtonFrame = CGRect(x: 20, y: 20, width: 60, height: 60)
    
    var gameBoardSize: (Int, Int)?
    var gameCards: [String] = []
    var firstGuess: Card?
    var matchesFound = 0
    
    var randomAnimation: UIView.AnimationOptions {
        return flipTransition.randomElement() ?? .transitionFlipFromRight
    }
    
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
        setBackground(with: "farm_game_bg")
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
        
        let backArrowImageView = BackArrow(frame: backButtonFrame)
        backArrowImageView.delegate = self
        backArrowImageView.alpha = K.alphaTransparent
        navigationController?.view.addSubview(backArrowImageView)
        
        // Fade Button in to transition better with navigational presentation
        UIView.animate(withDuration: K.fadeAnimationDuration) {
            backArrowImageView.alpha = K.alphaOpaque
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
        horizontalStackView.spacing = K.horizontalStackViewSpacing
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }
    
    
    // MARK: Error
    
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
    
    private func userGuess(with currentCardGuess: Card) {
        
        // First guess needs to exist to continue matching logic
        guard let firstCardGuess = firstGuess else {
            firstGuess = currentCardGuess
            return
        }
        
        if gameCards[firstCardGuess.tag] == gameCards[currentCardGuess.tag] {
            // celebarte match found
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + K.incorrectDelayTime) {
                self.incorrectAnimation(with: [firstCardGuess, currentCardGuess])
            }
        }
        
        firstGuess = nil
        
    }
    
    private func toggleInteraction(of card: Card) {
        card.isUserInteractionEnabled = card.isUserInteractionEnabled ? false : true
    }
    
    
    // MARK: Card Flip Animations
    
    private func guessAnimation(with card: Card) {
        UIView.transition(with: card, duration: K.flipAnimationDuration, options: randomAnimation, animations: {
            if let updateImage = UIImage(named: self.gameCards[card.tag]) {
                card.image = updateImage
            }
        }) { (success) in
            self.userGuess(with: card)
        }
    }
    
    private func incorrectAnimation(with cards: [Card]) {
        for card in cards {
            UIView.transition(with: card, duration: K.flipAnimationDuration, options: randomAnimation, animations: {
                card.image = UIImage(named: "allCardBacks")
                self.toggleInteraction(of: card)
            })
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
        toggleInteraction(of: sender)
        guessAnimation(with: sender)
    }
    
}
