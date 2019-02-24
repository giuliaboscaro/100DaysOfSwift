//
//  FlagDetailViewController.swift
//  Projects1-3-Milestone
//
//  Created by Giulia Boscaro on 23/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class FlagDetailViewController: UIViewController {
    
    var selectedFlag: String?
    var finalFlagName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    let flagImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        image.layer.shadowOpacity = 0.5
        image.layer.shadowRadius = 5.0
        image.layer.masksToBounds = false
        
        return image
    }()
    
    func setupView() {
        view.backgroundColor = UIColor.white
        
        if let flagName = selectedFlag {
            let formattedFlagName = flagName.replacingOccurrences(of: ".png", with: "")
            finalFlagName = formattedFlagName.count > 2 ? formattedFlagName.capitalized : formattedFlagName.uppercased()
            title  = finalFlagName
        }
        
        view.addSubview(flagImage)
        
        if let imageName = selectedFlag {
            flagImage.image = UIImage(named: imageName)
        }
        
        flagImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        flagImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        flagImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        flagImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func shareTapped() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, finalFlagName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
