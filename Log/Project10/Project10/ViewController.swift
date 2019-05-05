//
//  ViewController.swift
//  Project10
//
//  Created by Giulia Boscaro on 14/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var people = [Person]()
    var lockedView: UIView!
    var unlockButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Names to faces"
        
        collectionView.backgroundColor = .white
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "personCell")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        lockedView = UIView()
        lockedView.backgroundColor = .white
        lockedView.translatesAutoresizingMaskIntoConstraints = false
        lockedView.layer.zPosition = 3
        view.addSubview(lockedView)
        lockedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lockedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        lockedView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lockedView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        unlockButton = UIButton(type: .system)
        unlockButton.setTitle("Authenticate", for: .normal)
        unlockButton.addTarget(self, action: #selector(authenticate), for: .touchUpInside)
        unlockButton.translatesAutoresizingMaskIntoConstraints = false
        unlockButton.layer.zPosition = 4
        view.addSubview(unlockButton)
        
        unlockButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        unlockButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        unlockButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        lockedMode()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(lockedMode), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func lockedMode() {
        navigationItem.leftBarButtonItem = nil
        lockedView.isHidden = false
        unlockButton.isHidden = false
    }
    
    @objc func authenticate(_ : UIButton) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlock()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    func unlock() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        lockedView.isHidden = true
        unlockButton.isHidden = true
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

