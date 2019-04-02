//
//  Capital.swift
//  Project16
//
//  Created by Giulia Boscaro on 01/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    
}
