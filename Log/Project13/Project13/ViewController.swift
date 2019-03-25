//
//  ViewController.swift
//  Project13
//
//  Created by Giulia Boscaro on 24/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pictureFrame: UIView!
    var pictureView: UIImageView!
    var intensitySlider: UISlider!
    var changeFilterButton: UIButton!
    var saveButton: UIButton!
    var currentImage: UIImage!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        pictureFrame = UIView()
        pictureFrame.backgroundColor = .gray
        pictureFrame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pictureFrame)
        
        pictureView = UIImageView()
        pictureView.contentMode = .scaleAspectFit
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureFrame.addSubview(pictureView)
        
        let intensityLabel = UILabel()
        intensityLabel.text = "Intensity"
        intensityLabel.font = UIFont.preferredFont(forTextStyle: .body)
        intensityLabel.tintColor = .black
        intensityLabel.sizeToFit()
        intensityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(intensityLabel)
        
        intensitySlider = UISlider()
        intensitySlider.translatesAutoresizingMaskIntoConstraints = false
        intensitySlider.addTarget(self, action: #selector(intensityChanged), for: .valueChanged)
        view.addSubview(intensitySlider)
        
        changeFilterButton = UIButton(type: .system)
        changeFilterButton.translatesAutoresizingMaskIntoConstraints = false
        changeFilterButton.setTitle("Change Filter", for: .normal)
        changeFilterButton.addTarget(self, action: #selector(changeFilter), for: .touchUpInside)
        view.addSubview(changeFilterButton)
        
        saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            pictureFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            pictureFrame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            pictureFrame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            pictureFrame.heightAnchor.constraint(equalToConstant: 470),
            pictureView.topAnchor.constraint(equalTo: pictureFrame.topAnchor, constant: 10),
            pictureView.leadingAnchor.constraint(equalTo: pictureFrame.leadingAnchor, constant: 10),
            pictureView.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor, constant: -10),
            pictureView.bottomAnchor.constraint(equalTo: pictureFrame.bottomAnchor, constant: 10),
            intensityLabel.topAnchor.constraint(equalTo: pictureFrame.bottomAnchor, constant: 15),
            intensityLabel.leadingAnchor.constraint(equalTo: pictureFrame.leadingAnchor),
            intensityLabel.heightAnchor.constraint(equalToConstant: 50),
            intensitySlider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 15),
            intensitySlider.topAnchor.constraint(equalTo: pictureFrame.bottomAnchor, constant: 25),
            intensitySlider.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor),
            changeFilterButton.leadingAnchor.constraint(equalTo: intensityLabel.leadingAnchor),
            changeFilterButton.heightAnchor.constraint(equalToConstant: 44),
            changeFilterButton.widthAnchor.constraint(equalToConstant: 120),
            changeFilterButton.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            saveButton.topAnchor.constraint(equalTo: changeFilterButton.topAnchor),
            ])
        
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }

    @objc func changeFilter(_ sender: Any) {
        
    }
    
    @objc func save(_ sender: Any) {
        
    }
    
    @objc func intensityChanged(_ sender: Any) {
        
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
    }
}
