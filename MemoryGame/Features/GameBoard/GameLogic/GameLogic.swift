//
//  GameLogic.swift
//  MemoryGame
//
//  Created by Patrick Powers on 4/18/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import Foundation

protocol ReturnGameState: class {
    func gameIsOver()
    func secondGuessResults(isCorrect: Bool, firstGuess: Card, secondGuess: Card)
}

class GameLogic {
    
    // MARK: Data
    
    let possibleCards: Set<String> = ["memoryBatCardFront", "memoryCatCardFront", "memoryCowCardFront", "memoryDragonFront", "memoryGarbageManCardFront", "memoryGhostDogCardFront", "memoryHenCardFront", "memoryHorseCardFront", "memoryPigCardFront", "memorySpiderCardFront"]
    
    
    // MARK: Constants
    
    struct K {
        static let incorrectDelayTime = 1.0
    }
    
    
    // MARK: Variables
    
    weak var delegate: ReturnGameState?
    var gameBoardSize: (Int, Int)?
    var gameCards: [String] = []
    var firstGuess: Card?
    var matchesFound = 0
    
    init(with gameBoardSize: (Int, Int)?) {
        self.gameBoardSize = gameBoardSize
        generateCards()
    }
    
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
    
    internal func userGuess(with currentCardGuess: Card) {
        // First guess needs to exist to continue matching logic
        guard let firstCardGuess = firstGuess else {
            firstGuess = currentCardGuess
            return
        }
        
        if gameCards[firstCardGuess.tag] == gameCards[currentCardGuess.tag] {
            matchesFound += 1
            if matchesFound == gameCards.count / 2 {
                // Game Over
                delegate?.gameIsOver()
            } else {
                // Correct Match
                 delegate?.secondGuessResults(isCorrect: true, firstGuess: firstCardGuess, secondGuess: currentCardGuess)
            }
        } else {
            delegate?.secondGuessResults(isCorrect: false, firstGuess: firstCardGuess, secondGuess: currentCardGuess)
        }
        
        firstGuess = nil
    }
    
}
