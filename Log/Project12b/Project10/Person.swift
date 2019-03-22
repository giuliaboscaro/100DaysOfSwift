//
//  Person.swift
//  Project10
//
//  Created by Giulia Boscaro on 15/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

struct Person: Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
