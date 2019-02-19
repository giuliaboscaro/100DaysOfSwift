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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        
        if let pictureNumber = row, let total = numberOfPictures {
            title = "Picture \(pictureNumber) of \(total)"
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        let pictureImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            if let imageName = selectedImage {
                image.image = UIImage(named: imageName)
            }
            return image
        }()
        
        view.addSubview(pictureImage)
        
        pictureImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pictureImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pictureImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pictureImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    
}
