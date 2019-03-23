//
//  PhotoViewController.swift
//  Projects10-12-Milestone
//
//  Created by Giulia Boscaro on 22/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var imageName: String?
    let photoImage = UIImageView()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImage)
        NSLayoutConstraint.activate([
        photoImage.topAnchor.constraint(equalTo: view.topAnchor),
        photoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        photoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        photoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = imageName {
            let path = getDocumentsDirectory().appendingPathComponent(imageName)
            photoImage.image = UIImage(contentsOfFile: path.path)
        }
    }

}
