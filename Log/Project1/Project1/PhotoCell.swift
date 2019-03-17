//
//  PhotoCell.swift
//  Project1
//
//  Created by Giulia Boscaro on 16/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.frame = CGRect.init(x: 0, y: 0, width: 100, height: 120)
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    let photoName: UILabel = {
        let photoName = UILabel()
        photoName.frame = CGRect.init(x: 0, y: 0, width: 120, height: 40)
        photoName.text = "Name"
        photoName.font = UIFont(name: "Marker Felt Thin", size: 16)
        photoName.numberOfLines = 2
        photoName.translatesAutoresizingMaskIntoConstraints = false
        photoName.textAlignment = .center
        return photoName
    }()
    
    func setupViews() {
        backgroundColor = .white
        addSubview(photo)
        addSubview(photoName)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            photo.heightAnchor.constraint(equalToConstant: 120),
            photoName.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 5),
            photoName.trailingAnchor.constraint(equalTo: photo.trailingAnchor),
            photoName.leadingAnchor.constraint(equalTo: photo.leadingAnchor),
            photoName.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

}
