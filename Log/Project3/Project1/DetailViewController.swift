//
//  DetailViewController.swift
//  Project1
//
//  Created by Giulia Boscaro on 17/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedImage: String?
    var row: Int?
    var numberOfPictures: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        setupView()
    }
    
    @objc func shareTapped() {
        guard let image = pictureImage.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    let pictureImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupView() {
        view.backgroundColor = UIColor.white
        
        if let pictureNumber = row, let total = numberOfPictures {
            title = "Picture \(pictureNumber) of \(total)"
        }
        
        view.addSubview(pictureImage)
        
        if let imageName = selectedImage {
            pictureImage.image = UIImage(named: imageName)
        }
        
        pictureImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pictureImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pictureImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pictureImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    
}
