//
//  ViewController.swift
//  Project1
//
//  Created by Giulia Boscaro on 16/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pictureCell")
        
        performSelector(inBackground: #selector(fetchImages), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath)
        let sortedPictures = pictures.sorted()
        cell.textLabel?.text = sortedPictures[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let sortedPictures = pictures.sorted()
        vc.selectedImage = sortedPictures[indexPath.row]
        vc.row = indexPath.row + 1
        vc.numberOfPictures = pictures.count
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func fetchImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }


}

