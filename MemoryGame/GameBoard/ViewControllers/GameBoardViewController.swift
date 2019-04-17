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
    
    // MARK: Outlets
    
    @IBOutlet weak var cardVerticalStackView: UIStackView!
    
    
    // MARK: Lifecycle Events

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupBackButton()
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

