//
//  ViewController.swift
//  Project4-6-Milestone
//
//  Created by Giulia Boscaro on 04/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "itemCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear list", style: .plain, target: self, action: #selector(clearList))
        
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let newItemAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.items.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        ac.addAction(newItemAction)
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        items.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }


}

