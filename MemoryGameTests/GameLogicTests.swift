//
//  GameLogicTests.swift
//  GameLogicTests
//
//  Created by Patrick Powers on 4/18/19.
//  Copyright © 2019 Powers. All rights reserved.
//

import XCTest
@testable import MemoryGame

class GameLogicTests: XCTestCase {
    
    var gameCards: [String] = ["memoryCatCardFront", "memoryCatCardFront"]
    var gameLogic: GameLogic = GameLogic.init(with: (3, 4))
    let card1 = Card(frame: .zero)
    let card2 = Card(frame: .zero)
    
    func test_init() {
        let gridNumber = (gameLogic.gameBoardSize?.0)! * (gameLogic.gameBoardSize?.1)!
        XCTAssertEqual(gameLogic.gameCards.count, gridNumber)
    }

    func test_userGuess() {
        if gameLogic.firstGuess == nil {
            gameLogic.userGuess(with: card1)
            XCTAssertTrue(gameLogic.firstGuess == card1)
        }
        
        card1.tag = 0
        card2.tag = 1
        gameLogic.userGuess(with: card2)
        
        if self.gameCards[card1.tag] == self.gameCards[card2.tag] {
            XCTAssertTrue(gameLogic.firstGuess == nil)
        }
        
    }

}
