//
//  ViewController.swift
//  Project28
//
//  Created by Giulia Boscaro on 03/05/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    var secretTextView: UITextView!
    var authenticateButton: UIButton!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        secretTextView = UITextView()
        secretTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secretTextView)
        
        secretTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        secretTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        secretTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secretTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        authenticateButton = UIButton(type: .system)
        authenticateButton.setTitle("Authenticate", for: .normal)
        authenticateButton.addTarget(self, action: #selector(authenticateTapped), for: .touchUpInside)
        authenticateButton.translatesAutoresizingMaskIntoConstraints = false
        authenticateButton.layer.zPosition = -1
        authenticateButton.isHidden = true
        view.addSubview(authenticateButton)
        
        secretTextView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        secretTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secretTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func authenticateTapped(_ sender: UIButton) {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
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
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secretTextView.contentInset = .zero
        } else {
            secretTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secretTextView.scrollIndicatorInsets = secretTextView.contentInset
        
        let selectedRange = secretTextView.selectedRange
        secretTextView.scrollRangeToVisible(selectedRange)
        
    }
    
    func unlockSecretMessage() {
        secretTextView.isHidden = false
        title = "Secret stuff"
        
        secretTextView.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    }
    
    @objc func saveSecretMessage() {
        guard secretTextView.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secretTextView.text, forKey: "SecretMessage")
        secretTextView.resignFirstResponder()
        secretTextView.isHidden = true
        title = "Nothing to see here"
    }

}

