//
//  Country.swift
//  Projects13-15-Milestone
//
//  Created by Giulia Boscaro on 31/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var region: String
    var population: Int
    var timezones: [String]
    var languages: [Languages]
}

struct Languages: Codable {
    var name: String
}
