//
//  PhotoViewController.swift
//  Projects10-12-Milestone
//
//  Created by Giulia Boscaro on 22/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photo: Photo?
    let photoImage = UIImageView()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImage)
        NSLayoutConstraint.activate([
        photoImage.topAnchor.constraint(equalTo: view.topAnchor),
        photoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        photoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        photoImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = photo {
            let path = getDocumentsDirectory().appendingPathComponent(photo.fileName)
            photoImage.image = UIImage(contentsOfFile: path.path)
        }
    }

}
