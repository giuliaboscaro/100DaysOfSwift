//
//  ViewController.swift
//  Project1
//
//  Created by Giulia Boscaro on 16/02/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pictures = [String]()
    var counts: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pictureCell")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        performSelector(inBackground: #selector(fetchImages), with: nil)
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath)
//        let sortedPictures = pictures.sorted()
//        cell.textLabel?.text = sortedPictures[indexPath.row]
//        cell.accessoryType = .disclosureIndicator
//        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
//        return cell
//    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError()
        }
        let sortedPictures = pictures.sorted()
        cell.photoName.text = sortedPictures[indexPath.item]
        cell.photo.image = UIImage(named: sortedPictures[indexPath.item])
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        let sortedPictures = pictures.sorted()
//        vc.selectedImage = sortedPictures[indexPath.row]
//        vc.row = indexPath.row + 1
//        vc.numberOfPictures = pictures.count
//        navigationController?.pushViewController(vc, animated: true)
//
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        countOpening(index: indexPath)
        let vc = DetailViewController()
        let sortedPictures = pictures.sorted()
        vc.selectedImage = sortedPictures[indexPath.item]
        vc.row = indexPath.item + 1
        vc.numberOfPictures = pictures.count
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
        
        collectionView.performSelector(onMainThread: #selector(collectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    func countOpening(index: IndexPath) {
        let defaults = UserDefaults.standard
        counts[index.item] += 1
        defaults.set(counts[index.item] , forKey: pictures[index.item])
        let savedCount = defaults.integer(forKey: pictures[index.item])
        print(savedCount)
    }

}

