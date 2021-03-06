//
//  ViewController.swift
//  Project13
//
//  Created by Giulia Boscaro on 24/03/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    var pictureFrame: UIView!
    var pictureView: UIImageView!
    var intensitySlider: UISlider!
    var radiusSlider: UISlider!
    var changeFilterButton: UIButton!
    var saveButton: UIButton!
    var currentImage: UIImage!
    
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pictureView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [], animations: {
            self.pictureView.alpha = 1.0
        }, completion: nil)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        pictureFrame = UIView()
        pictureFrame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pictureFrame)
        
        pictureView = UIImageView()
        pictureView.contentMode = .scaleAspectFit
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureFrame.addSubview(pictureView)
        
        let intensityLabel = UILabel()
        intensityLabel.text = "Intensity"
        intensityLabel.font = UIFont.preferredFont(forTextStyle: .body)
        intensityLabel.tintColor = .black
        intensityLabel.sizeToFit()
        intensityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(intensityLabel)
        
        intensitySlider = UISlider()
        intensitySlider.translatesAutoresizingMaskIntoConstraints = false
        intensitySlider.addTarget(self, action: #selector(intensityChanged), for: .valueChanged)
        view.addSubview(intensitySlider)
        
        let radiusLabel = UILabel()
        radiusLabel.text = "Radius"
        radiusLabel.font = UIFont.preferredFont(forTextStyle: .body)
        radiusLabel.tintColor = .black
        radiusLabel.sizeToFit()
        radiusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(radiusLabel)
        
        radiusSlider = UISlider()
        radiusSlider.translatesAutoresizingMaskIntoConstraints = false
        radiusSlider.addTarget(self, action: #selector(radiusChanged), for: .valueChanged)
        view.addSubview(radiusSlider)
        
        changeFilterButton = UIButton(type: .system)
        changeFilterButton.translatesAutoresizingMaskIntoConstraints = false
        changeFilterButton.setTitle("Change Filter", for: .normal)
        changeFilterButton.addTarget(self, action: #selector(changeFilter), for: .touchUpInside)
        view.addSubview(changeFilterButton)
        
        saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            pictureFrame.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            pictureFrame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            pictureFrame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            pictureFrame.heightAnchor.constraint(equalToConstant: 300),
            pictureView.topAnchor.constraint(equalTo: pictureFrame.topAnchor, constant: 10),
            pictureView.leadingAnchor.constraint(equalTo: pictureFrame.leadingAnchor, constant: 10),
            pictureView.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor, constant: -10),
            pictureView.bottomAnchor.constraint(equalTo: pictureFrame.bottomAnchor, constant: 10),
            intensityLabel.topAnchor.constraint(equalTo: pictureFrame.bottomAnchor, constant: 15),
            intensityLabel.leadingAnchor.constraint(equalTo: pictureFrame.leadingAnchor),
            intensityLabel.heightAnchor.constraint(equalToConstant: 50),
            intensitySlider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 15),
            intensitySlider.topAnchor.constraint(equalTo: pictureFrame.bottomAnchor, constant: 25),
            intensitySlider.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor),
            changeFilterButton.leadingAnchor.constraint(equalTo: intensityLabel.leadingAnchor),
            changeFilterButton.heightAnchor.constraint(equalToConstant: 44),
            changeFilterButton.widthAnchor.constraint(equalToConstant: 120),
            changeFilterButton.topAnchor.constraint(equalTo: radiusLabel.bottomAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            saveButton.topAnchor.constraint(equalTo: changeFilterButton.topAnchor),
            radiusLabel.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 15),
            radiusLabel.leadingAnchor.constraint(equalTo: intensityLabel.leadingAnchor),
            radiusLabel.heightAnchor.constraint(equalToConstant: 50),
            radiusSlider.leadingAnchor.constraint(equalTo: intensitySlider.leadingAnchor),
            radiusSlider.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 35),
            radiusSlider.trailingAnchor.constraint(equalTo: pictureFrame.trailingAnchor),
            ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }

    @objc func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose a filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        present(ac, animated: true)
    }
    
    @objc func save(_ sender: Any) {
        if let image = pictureView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            let ac = UIAlertController(title: "No picture selected", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    @objc func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    @objc func radiusChanged(_ sender: Any) {
        applyProcessing()
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensitySlider.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radiusSlider.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensitySlider.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            pictureView.image = processedImage
        }
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        currentFilter = CIFilter(name: actionTitle)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        changeFilterButton.setTitle(action.title, for: .normal)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
}
