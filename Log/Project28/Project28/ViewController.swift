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
        secretTextView.layer.zPosition = 2
        secretTextView.isHidden = true
        view.addSubview(secretTextView)
        
        secretTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        secretTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        secretTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        secretTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        authenticateButton = UIButton(type: .system)
        authenticateButton.setTitle("Authenticate", for: .normal)
        authenticateButton.addTarget(self, action: #selector(loginOrCreatePassword), for: .touchUpInside)
        authenticateButton.layer.zPosition = 1
        authenticateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authenticateButton)
        
        authenticateButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        authenticateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authenticateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveSecretMessage))
    }
    
    @objc func saveSecretMessage() {
        guard secretTextView.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secretTextView.text, forKey: "SecretMessage")
        secretTextView.resignFirstResponder()
        secretTextView.isHidden = true
        title = "Nothing to see here"
        
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc func loginOrCreatePassword() {
        let ac = UIAlertController(title: "Do you have a password?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "No, create one", style: .default, handler: createPassword))
        ac.addAction(UIAlertAction(title: "Yes, let me login", style: .default, handler: giveLoginOptions))
        present(ac, animated: true)
    }
    
    func createPassword(action: UIAlertAction) {
        let ac = UIAlertController(title: "Enter a password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].isSecureTextEntry = true
        ac.addAction(UIAlertAction(title: "Registrate", style: .default, handler: { [weak self] _ in
            guard let newPassword = ac.textFields?[0].text else { return }
            KeychainWrapper.standard.set(newPassword, forKey: "password")
            self?.dismiss(animated: true)
            let ac = UIAlertController(title: "Password saved successfully", message: "Now proceed to login", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(ac, animated: true)
        }))
        present(ac, animated: true)
    }
    
    func giveLoginOptions(action: UIAlertAction) {
        let ac = UIAlertController(title: "Choose login mode", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Password", style: .default, handler: passwordLoginChosen))
        ac.addAction(UIAlertAction(title: "Touch ID / Face ID", style: .default, handler: touchIdOrFaceIdChosen))
        present(ac, animated: true)
    }
    
    func passwordLoginChosen(action: UIAlertAction) {
        let ac = UIAlertController(title: "Enter your password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].isSecureTextEntry = true
        ac.addAction(UIAlertAction(title: "Login", style: .default, handler: { [weak self] (action) in
            guard let passwordTyped = ac.textFields?[0].text else { return }
            self?.checkPassword(passwordTyped: passwordTyped)
        }))
        present(ac, animated: true)
    }
    
    func touchIdOrFaceIdChosen(action: UIAlertAction) {
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
    
    func checkPassword(passwordTyped: String) {
        guard let password = KeychainWrapper.standard.string(forKey: "password") else { return }
        
        if passwordTyped == password {
            unlockSecretMessage()
        } else {
            let ac = UIAlertController(title: "Wrong password", message: "Try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default))
            present(ac, animated: true)
        }
    }
    
}

