//
//  Photo.swift
//  Projects10-12-Milestone
//
//  Created by Giulia Boscaro on 22/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var fileName: String
    var caption: String
    
    init(fileName: String, caption: String) {
        self.fileName = fileName
        self.caption = caption
    }
}
