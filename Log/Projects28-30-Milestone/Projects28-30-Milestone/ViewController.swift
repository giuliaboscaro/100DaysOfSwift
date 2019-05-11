//
//  ViewController.swift
//  Projects28-30-Milestone
//
//  Created by Giulia Boscaro on 11/05/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wordsArray: [String] = ["Horse", "Cheese", "Rouge", "Fromage", "Apple", "Cheval", "Pomme", "Red"]
    
    var wordsDictonary: [String: String] = [
        "Pomme": "Apple",
        "Rouge": "Red",
        "Fromage": "Cheese",
        "Cheval": "Horse"
    ]
    
    var buttonsArray = [UIButton]()
    
    var cardsSelected = 0
    var cardPair = [UIButton]()
    var matches = 0

    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        for i in 0...7 {
            let button = UIButton(type: .custom)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .black
            button.frame = CGRect(x: 0, y: 0, width: 160, height: 140)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonsArray.append(button)
            buttonsArray[i].setTitle(wordsArray[i], for: .normal)
            button.addTarget(self, action: #selector(cardTouched), for: .touchUpInside)
            view.addSubview(button)
        }
        
        buttonsArray[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonsArray[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        buttonsArray[0].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[0].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[1].leadingAnchor.constraint(equalTo: buttonsArray[0].trailingAnchor, constant: 30).isActive = true
        buttonsArray[1].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        buttonsArray[1].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[1].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonsArray[2].topAnchor.constraint(equalTo: buttonsArray[0].bottomAnchor, constant: 20).isActive = true
        buttonsArray[2].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[2].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[3].leadingAnchor.constraint(equalTo: buttonsArray[2].trailingAnchor, constant: 30).isActive = true
        buttonsArray[3].topAnchor.constraint(equalTo: buttonsArray[1].bottomAnchor, constant: 20).isActive = true
        buttonsArray[3].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[3].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[4].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonsArray[4].topAnchor.constraint(equalTo: buttonsArray[2].bottomAnchor, constant: 20).isActive = true
        buttonsArray[4].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[4].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[5].leadingAnchor.constraint(equalTo: buttonsArray[4].trailingAnchor, constant: 30).isActive = true
        buttonsArray[5].topAnchor.constraint(equalTo: buttonsArray[3].bottomAnchor, constant: 20).isActive = true
        buttonsArray[5].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[5].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[6].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        buttonsArray[6].topAnchor.constraint(equalTo: buttonsArray[4].bottomAnchor, constant: 20).isActive = true
        buttonsArray[6].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[6].heightAnchor.constraint(equalToConstant: 140).isActive = true
        buttonsArray[7].leadingAnchor.constraint(equalTo: buttonsArray[6].trailingAnchor, constant: 30).isActive = true
        buttonsArray[7].topAnchor.constraint(equalTo: buttonsArray[5].bottomAnchor, constant: 20).isActive = true
        buttonsArray[7].widthAnchor.constraint(equalToConstant: 160).isActive = true
        buttonsArray[7].heightAnchor.constraint(equalToConstant: 140).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Memory game"
        
        
    }
    
    
    
    @objc func cardTouched(_ sender: UIButton) {
        cardsSelected += 1

        if cardsSelected < 3 {
            sender.setTitleColor(.white, for: .normal)
            cardPair.append(sender)
        }

        if cardsSelected == 2 {
            let firstCard = cardPair[0]
            let secondCard = cardPair[1]

            if wordsDictonary[(firstCard.titleLabel?.text!)!] == secondCard.titleLabel?.text! {
                secondCard.setTitleColor(.white, for: .normal)
                
                UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: {
                    firstCard.alpha = 0
                    secondCard.alpha = 0
                }, completion: nil)
                sender.isUserInteractionEnabled = false
                matches += 1
                cardsSelected = 0
            } else if wordsDictonary[(secondCard.titleLabel?.text!)!] == firstCard.titleLabel?.text! {
                firstCard.setTitleColor(.white, for: .normal)
                
                UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: {
                    firstCard.alpha = 0
                    secondCard.alpha = 0
                }, completion: nil)
                
                sender.isUserInteractionEnabled = false
                matches += 1
                cardsSelected = 0
            } else {
                secondCard.setTitleColor(.white, for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                firstCard.setTitleColor(.black, for: .normal)
                secondCard.setTitleColor(.black, for: .normal)
                }
                cardsSelected = 0
            }

            cardPair = []
        }
        
        if matches == 4 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let wonLabel = UILabel()
                wonLabel.text = "You won! Congratulations"
                wonLabel.font = UIFont.systemFont(ofSize: 18)
                wonLabel.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(wonLabel)
                
                wonLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                wonLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            }
            
        }

    }
    
    func hide(card1: UIButton, card2: UIButton) {
        
    }
    
    
    
    


}

