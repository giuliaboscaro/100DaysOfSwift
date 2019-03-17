//
//  ViewController.swift
//  Project10
//
//  Created by Giulia Boscaro on 14/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "personCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as? PersonCell else {
            fatalError()
        }
        let person = people[indexPath.item]
        cell.personName.text = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.personPhoto.image = UIImage(contentsOfFile: path.path)
        cell.personPhoto.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.personPhoto.layer.borderWidth = 2
        cell.personPhoto.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showOptionAlert(index: indexPath)
    }
    
    func showOptionAlert(index: IndexPath) {
        let ac = UIAlertController(title: "Edit contact", message: nil, preferredStyle: .alert)
        
        let renameAction = UIAlertAction(title: "Rename", style: .default) {[weak self] _ in
            let person = self?.people[index.item]
            let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
                guard let newName = ac?.textFields?[0].text else { return }
                person?.name = newName
                self?.collectionView.reloadData()
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(ac, animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {[weak self] _ in
            self?.people.remove(at: index.item)
            self?.collectionView.reloadData()
        }
        
        ac.addAction(renameAction)
        ac.addAction(deleteAction)
        
        present(ac, animated: true)
    }
    
    
    
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let person = Person(name: "Unkown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    
}

