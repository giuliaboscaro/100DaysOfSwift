//
//  NoteViewController.swift
//  Projects19-21-Milestone
//
//  Created by Giulia Boscaro on 15/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    var noteArea: UITextView!
    
    override func loadView() {
        view = UIView()
        
        noteArea = UITextView()
        noteArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noteArea)
        
        noteArea.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        noteArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        noteArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        noteArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let newNote = Note(text: noteArea.text)
        
    }
    
    
}
