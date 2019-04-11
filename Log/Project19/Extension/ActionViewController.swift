//
//  ActionViewController.swift
//  Extension
//
//  Created by Giulia Boscaro on 08/04/19.
//  Copyright © 2019 Giulia Boscaro. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(chooseScript))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) {
                    [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                    
                    let defaults = UserDefaults.standard
                    if let savedScript = defaults.object(forKey: self?.pageURL ?? "") as? String {
                        self?.script.text = savedScript
                    }
                }
            }
        }
        
        
    }
    
    func execute(script: String) {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
        save(data: script)
    }
    
    func save(data: Any) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: pageURL)
    }

    @IBAction func done() {
        execute(script: script.text)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func chooseScript() {
        let ac = UIAlertController(title: "Choose a script", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "alert(document.title);", style: .default, handler: { action in
            guard let script = action.title else { return }
            self.execute(script: script)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(ac, animated: true)
    }

}
