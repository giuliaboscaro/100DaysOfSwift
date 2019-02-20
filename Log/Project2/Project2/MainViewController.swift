//
//  ViewController.swift
//  Project2
//
//  Created by Giulia Boscaro on 19/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var countries = [String]()
    var score = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestions()
    }
    
    func askQuestions() {
        firstButtom.setImage(UIImage(named: countries[0]), for: .normal)
        secondButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    let firstButtom: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let secondButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let thirdButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func setupView() {
        
        view.backgroundColor = UIColor.white
        view.addSubview(firstButtom)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        
        firstButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        firstButtom.heightAnchor.constraint(equalToConstant: 100).isActive = true
        firstButtom.widthAnchor.constraint(equalToConstant: 200).isActive = true
        firstButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        secondButton.topAnchor.constraint(equalTo: firstButtom.bottomAnchor, constant: 20).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        secondButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 20).isActive = true
        thirdButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        thirdButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    
    
    
}

