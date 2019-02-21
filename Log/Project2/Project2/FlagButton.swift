//
//  FlagButton.swift
//  Project2
//
//  Created by Giulia Boscaro on 20/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class flagButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
