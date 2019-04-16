//
//  ViewController.swift
//  Projects19-21-Milestone
//
//  Created by Giulia Boscaro on 15/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var notes: [Note] = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].text
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    @objc func addNewNote() {
        let noteAc = NoteViewController()
        navigationController?.pushViewController(noteAc, animated: true)
    }

}

