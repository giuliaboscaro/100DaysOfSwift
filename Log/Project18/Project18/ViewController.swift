//
//  ViewController.swift
//  Project18
//
//  Created by Giulia Boscaro on 06/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Im inside the viewDidLoad() method!")
        print(1, 2, 3, 4, 5)
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "")
        
        assert(1 == 1, "Math failure!")
        assert(1 == 2, "Math failure!")
        
        for i in 1...100 {
            print("Got number \(i).")
        }
    }


}

