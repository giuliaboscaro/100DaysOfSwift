//
//  ViewController.swift
//  Projects25-27-Milestone
//
//  Created by Giulia Boscaro on 01/05/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var memeView: UIImageView!
    var topFraseTextField: UITextField!
    var bottomFraseTextField: UITextField!
    var generateButton: UIButton!
    
    var chosenImage: UIImage?
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        memeView = UIImageView()
        memeView.translatesAutoresizingMaskIntoConstraints = false
        memeView.contentMode = .scaleAspectFit
        view.addSubview(memeView)
        
        topFraseTextField = UITextField()
        topFraseTextField.placeholder = "Write the top frase here"
        topFraseTextField.translatesAutoresizingMaskIntoConstraints = false
        topFraseTextField.borderStyle = .line
        view.addSubview(topFraseTextField)
        
        bottomFraseTextField = UITextField()
        bottomFraseTextField.placeholder = "Write the bottom frase here"
        bottomFraseTextField.translatesAutoresizingMaskIntoConstraints = false
        bottomFraseTextField.borderStyle = .line
        view.addSubview(bottomFraseTextField)
        
        generateButton = UIButton(type: .custom)
        generateButton.setTitle("Generate meme", for: .normal)
        generateButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        generateButton.setTitleColor(.black, for: .normal)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.addTarget(self, action: #selector(generateMeme), for: .touchUpInside)
        view.addSubview(generateButton)
        
        memeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        memeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        memeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        memeView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        topFraseTextField.topAnchor.constraint(equalTo: memeView.bottomAnchor, constant: 20).isActive = true
        topFraseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        topFraseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        topFraseTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomFraseTextField.topAnchor.constraint(equalTo: topFraseTextField.bottomAnchor, constant: 20).isActive = true
        bottomFraseTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomFraseTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomFraseTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        generateButton.topAnchor.constraint(equalTo: bottomFraseTextField.bottomAnchor, constant: 20).isActive = true
        generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        generateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        generateButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meme generator"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(selectMemePicture))
    }
    
    @objc func generateMeme() {
        
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func selectMemePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        chosenImage = image
        memeView.image = chosenImage
        dismiss(animated: true)
    }
}

