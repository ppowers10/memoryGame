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
    
    let flipTransition: [UIView.AnimationOptions] = [.transitionFlipFromRight, .transitionFlipFromLeft, .transitionFlipFromTop, .transitionFlipFromBottom]
    let backButtonFrame = CGRect(x: 20, y: 20, width: 60, height: 60)
    let answerStatusFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
    
    var gameBoardSize: (Int, Int)?
    var gameLogic: GameLogic? = nil
    
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
        setupGameLogic()
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
        
        for rowIndex in 1...rows {
            let horizontalStackView = createHorizontalStackView()
            cardVerticalStackView.addArrangedSubview(horizontalStackView)
            for columnIndex in 1...columns {
                // Prevent a grid from being built that has an odd number
                if rowIndex == rows && columnIndex == columns && cardNumber % 2 == 0 { break }
                
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
        let alert = UIAlertController(title: "ui.error.title".localized, message: "ui.error.message".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ui.error.darnButton".localized, style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    // MARK: Game Logic
    
    private func setupGameLogic() {
        gameLogic = GameLogic(with: gameBoardSize)
        gameLogic?.delegate = self
    }
    
    
    
    
    // MARK: Animations and Interaction
    
    private func guessAnimation(with card: Card) {
        UIView.transition(with: card, duration: K.flipAnimationDuration, options: randomAnimation, animations: {
            if let gameLogic = self.gameLogic,
                let updateImage = UIImage(named: gameLogic.gameCards[card.tag]) {
                card.image = updateImage
            }
        }) { (success) in
            self.gameLogic?.userGuess(with: card)
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
    
    private func toggleInteraction(of card: Card) {
        card.isUserInteractionEnabled = card.isUserInteractionEnabled ? false : true
    }

}


extension GameBoardViewController: ReturnGameState {
    func secondGuessResults(isCorrect: Bool, firstGuess: Card, secondGuess: Card) {
        if isCorrect {
            let correctView = AnswerStatusImageView(frame: answerStatusFrame, isCorrect: true)
            correctView.center = view.center
            self.view.addSubview(correctView)
            DispatchQueue.main.asyncAfter(deadline: .now() + K.incorrectDelayTime) {
                correctView.removeFromSuperview()
            }
        } else {
            let incorrectView = AnswerStatusImageView(frame: answerStatusFrame, isCorrect: false)
            incorrectView.center = view.center
            self.view.addSubview(incorrectView)
            DispatchQueue.main.asyncAfter(deadline: .now() + K.incorrectDelayTime) {
                incorrectView.removeFromSuperview()
                self.incorrectAnimation(with: [firstGuess, secondGuess])
            }
        }
    }
    
    func gameIsOver() {
        for _ in 1...10 {
            let correctView = AnswerStatusImageView(frame: answerStatusFrame, isCorrect: true)
            correctView.center = view.center
            self.view.addSubview(correctView)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat, .autoreverse, .beginFromCurrentState], animations: {
                correctView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }, completion: nil)
            
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
