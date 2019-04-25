//
//  PhotoCell.swift
//  Project25
//
//  Created by Giulia Boscaro on 24/04/19.
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
        photo.frame = CGRect.init(x: 0, y: 0, width: 145, height: 145)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.tag = 1000
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    func setupViews() {
        addSubview(photo)
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.heightAnchor.constraint(equalToConstant: 145),
            photo.widthAnchor.constraint(equalToConstant: 145)
            ])
    }
    
}

