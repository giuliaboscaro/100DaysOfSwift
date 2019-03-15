//
//  PersonCell.swift
//  Project10
//
//  Created by Giulia Boscaro on 14/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let personPhoto: UIImageView = {
        let personPhoto = UIImageView()
        personPhoto.frame = CGRect.init(x: 0, y: 0, width: 120, height: 120)
        personPhoto.translatesAutoresizingMaskIntoConstraints = false
        return personPhoto
    }()
    
    let personName: UILabel = {
        let personName = UILabel()
        personName.frame = CGRect.init(x: 0, y: 0, width: 120, height: 40)
        personName.text = "Name"
        personName.font = UIFont(name: "Marker Felt Thin", size: 16)
        personName.numberOfLines = 2
        personName.translatesAutoresizingMaskIntoConstraints = false
        return personName
    }()
    
    func setupViews() {
        backgroundColor = .white
        addSubview(personPhoto)
        addSubview(personName)
        
        NSLayoutConstraint.activate([
            personPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            personPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            personPhoto.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            personPhoto.heightAnchor.constraint(equalToConstant: 120),
            personName.topAnchor.constraint(equalTo: personPhoto.bottomAnchor, constant: 10),
            personName.trailingAnchor.constraint(equalTo: personPhoto.trailingAnchor),
            personName.leadingAnchor.constraint(equalTo: personPhoto.leadingAnchor),
            personName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
