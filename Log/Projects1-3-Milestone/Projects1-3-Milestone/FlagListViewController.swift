//
//  ViewController.swift
//  Projects1-3-Milestone
//
//  Created by Giulia Boscaro on 23/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class FlagListViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Choose a flag"
        loadFlags()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "flagCell")
        
    }
    
    func loadFlags() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
        
        let countryName = flags[indexPath.row].replacingOccurrences(of: ".png", with: "")
        
        let flagIdentifier = countryName.count > 2 ? countryName.capitalized : countryName.uppercased()
        cell.textLabel?.text = flagIdentifier
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
//        cell.imageView?.layer.borderWidth = 1
//        cell.imageView?.layer.borderColor = UIColor.gray.cgColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FlagDetailViewController()
        vc.selectedFlag = flags[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

