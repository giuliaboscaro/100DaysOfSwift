//
//  ViewController.swift
//  Project6b
//
//  Created by Giulia Boscaro on 02/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let label1 = createLabel(text: "THESE", bgColor: .red)
        let label2 = createLabel(text: "ARE", bgColor: .cyan)
        let label3 = createLabel(text: "SOME", bgColor: .yellow)
        let label4 = createLabel(text: "AWESOME", bgColor: .green)
        let label5 = createLabel(text: "LABELS", bgColor: .orange)
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//
//        }
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            previous = label
        }

    }

    func createLabel(text: String, bgColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = bgColor
        label.text = text
        label.sizeToFit()
        
        return label
    }
}

