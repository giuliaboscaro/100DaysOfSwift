//
//  ViewController.swift
//  Projects7-9-Milestone
//
//  Created by Giulia Boscaro on 13/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var currentLetter: UITextField!
    var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadWord), with: nil)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont.systemFont(ofSize: 30)
        clueLabel.text = "CLUE"
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 50)
        answerLabel.text = "ANSWER"
        
        currentLetter = UITextField()
        currentLetter.translatesAutoresizingMaskIntoConstraints = false
        currentLetter.placeholder = "Enter a letter"
        currentLetter.textAlignment = .center
        currentLetter.font = UIFont.systemFont(ofSize: 44)
        currentLetter.isUserInteractionEnabled = true
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        submit.addTarget(self, action: #selector(submitLetter), for: .touchUpInside)
        
        view.addSubview(clueLabel)
        view.addSubview(answerLabel)
        view.addSubview(currentLetter)
        view.addSubview(submit)
        
        NSLayoutConstraint.activate([
        clueLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        clueLabel.heightAnchor.constraint(equalToConstant: 80),
        answerLabel.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 80),
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        answerLabel.heightAnchor.constraint(equalToConstant: 150),
        currentLetter.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 30),
        currentLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        currentLetter.heightAnchor.constraint(equalToConstant: 60),
        submit.topAnchor.constraint(equalTo: currentLetter.bottomAnchor, constant: 20),
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        submit.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func submitLetter(_sender: UIButton) {
        
    }
    
    @objc func loadWord() {
        var clueString = ""
        var solutionString = ""
        
    }

}

