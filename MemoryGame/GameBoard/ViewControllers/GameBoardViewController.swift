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
    lazy var backButtonImageView: UIImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 60, height: 60))
    
    
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
        
        if let imgBackArrow = UIImage(named: "backNavButton") {
            backButtonImageView.image = imgBackArrow
        }
        
        backButtonImageView.alpha = 0.0
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(backTap)
        navigationController?.view.addSubview(backButtonImageView)
        
        UIView.animate(withDuration: 0.8) {
            self.backButtonImageView.alpha = 1.0
        }
        
    }
    
    @objc func backToMain() {
        backButtonImageView.removeFromSuperview()
        navigationController?.popViewController(animated: true)
    }
    

    private func presentError() {
        let alert = UIAlertController(title: "Sorry", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Darn", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}


