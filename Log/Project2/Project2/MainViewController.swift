//
//  ViewController.swift
//  Project2
//
//  Created by Giulia Boscaro on 19/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var firstButton = flagButton()
    var secondButton = flagButton()
    var thirdButton = flagButton()
    
    var countries = [String]()
    var score = 0
    var round = 1
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLabels()
        firstButton.tag = 0
        secondButton.tag = 1
        thirdButton.tag = 2
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestions()
        
        [firstButton, secondButton, thirdButton].forEach { (button) in
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        firstButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roundLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupLabels() {
        let navBar = self.navigationController?.navigationBar
        navBar?.addSubview(scoreLabel)
        navBar?.addSubview(roundLabel)
        scoreLabel.rightAnchor.constraint(equalTo: (navBar?.rightAnchor)!, constant: -20).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: (navBar?.topAnchor)!, constant: 10).isActive = true
        roundLabel.leftAnchor.constraint(equalTo: (navBar?.leftAnchor)!, constant: 20).isActive = true
        roundLabel.topAnchor.constraint(equalTo: (navBar?.topAnchor)!, constant: 10).isActive = true
        updateLabels()
        
    }
    
    func updateLabels() {
        scoreLabel.text = "Score: \(score)"
        roundLabel.text = "Round: \(round)"
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        
        firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        firstButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 20).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        secondButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 20).isActive = true
        thirdButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        thirdButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        var title: String
        var message: String
        var actionTitle: String = "Continue"
        
        
        if sender.tag == correctAnswer && round != 10 {
                title = "Correct"
                score += 1
                message = "+1 point"
            
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                    alert.dismiss(animated: true, completion: nil)
                    self.askQuestions()
                }
                alert.addAction(action)
                present(alert, animated: true)
            
        } else if sender.tag != correctAnswer && round != 10 {
                title = "Wrong"
                score -= 1
                message = "That's the flag of \(countries[sender.tag].uppercased()), -1 point"
            
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                    alert.dismiss(animated: true, completion: nil)
                    self.askQuestions()
                }
                alert.addAction(action)
                present(alert, animated: true)
            
        } else {
            title = "End game"
            message = "You scored \(score)"
            actionTitle = "Start again"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let shareAction = UIAlertAction(title: "Share score", style: .default) { (action) in
                let vc = UIActivityViewController(activityItems: [self.score], applicationActivities: [])
                vc.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
                self.present(vc, animated: true)
            }
            let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
                self.askQuestions()
            }
            
            alert.addAction(action)
            alert.addAction(shareAction)
            present(alert, animated: true)
            
            round = 0
            score = 0
        }
        
        round += 1
        updateLabels()
        
    }
    
}

