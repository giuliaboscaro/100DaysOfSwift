//
//  ViewController.swift
//  Projects10-12-Milestone
//
//  Created by Giulia Boscaro on 22/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "photoNameCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
        loadPhotos()
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoNameCell", for: indexPath)
        cell.textLabel?.text = photos[indexPath.row].caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoViewController()
        let photo = photos[indexPath.row]
        vc.imageName = photo.fileName
        print(photo.fileName)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func savePhoto() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
        } else {
            print("Unable to save photos")
        }
    }
    
    func loadPhotos() {
        let defaults = UserDefaults.standard
        if let savedPhotos = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedPhotos)
            } catch {
                print("Failed to load photos")
            }
        }
    }

}

extension ListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func addNewPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let photo = Photo(fileName: imageName, caption: "Unknown")
        photos.append(photo)
        savePhoto()
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    
}

