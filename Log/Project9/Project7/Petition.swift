//
//  Petition.swift
//  Project7
//
//  Created by Giulia Boscaro on 05/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}
