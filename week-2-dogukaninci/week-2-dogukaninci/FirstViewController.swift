//
//  ViewController.swift
//  week-2-dogukaninci
//
//  Created by Doğukan Inci on 26.05.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    private var notificationCenterTextLabel = UILabel()
    private var delegateTextLabel = UILabel()
    private var closureTextLabel = UILabel()
    private var notificationCenterTextField = UITextField()
    private var delegateTextField = UITextField()
    private var closureTextField = UITextField()
    private var sendButton = UIButton(type: .system)
    
    private var sharedConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupLayout()
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        setViewDetails()
    }
    
    /// Adds subviews to the main view controller
    private func addViews() {
        view.addSubview(notificationCenterTextLabel)
        view.addSubview(delegateTextLabel)
        view.addSubview(closureTextLabel)
        view.addSubview(notificationCenterTextField)
        view.addSubview(delegateTextField)
        view.addSubview(closureTextField)
        view.addSubview(sendButton)
    }
    
    /// Sets layouts
    private func setupLayout() {
        notificationCenterTextField.translatesAutoresizingMaskIntoConstraints = false
        notificationCenterTextLabel.translatesAutoresizingMaskIntoConstraints = false
        delegateTextField.translatesAutoresizingMaskIntoConstraints = false
        delegateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        closureTextField.translatesAutoresizingMaskIntoConstraints = false
        closureTextLabel.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        notificationCenterTextLabel.textAlignment = .center
        delegateTextLabel.textAlignment = .center
        closureTextLabel.textAlignment = .center
        
        sharedConstraints.append(contentsOf: [
            notificationCenterTextLabel.heightAnchor.constraint(equalToConstant: 44),
            notificationCenterTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            notificationCenterTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            notificationCenterTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            notificationCenterTextField.heightAnchor.constraint(equalToConstant: 44),
            notificationCenterTextField.topAnchor.constraint(equalTo: notificationCenterTextLabel.bottomAnchor, constant: 10),
            notificationCenterTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            notificationCenterTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            delegateTextLabel.heightAnchor.constraint(equalToConstant: 44),
            delegateTextLabel.topAnchor.constraint(equalTo: notificationCenterTextField.bottomAnchor, constant: 10),
            delegateTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            delegateTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            delegateTextField.heightAnchor.constraint(equalToConstant: 44),
            delegateTextField.topAnchor.constraint(equalTo: delegateTextLabel.bottomAnchor, constant: 10),
            delegateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            delegateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            closureTextLabel.heightAnchor.constraint(equalToConstant: 44),
            closureTextLabel.topAnchor.constraint(equalTo: delegateTextField.bottomAnchor, constant: 10),
            closureTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            closureTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            closureTextField.heightAnchor.constraint(equalToConstant: 44),
            closureTextField.topAnchor.constraint(equalTo: closureTextLabel.bottomAnchor, constant: 10),
            closureTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            closureTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: closureTextField.bottomAnchor, constant: 30),
            sendButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }
    private func setViewDetails() {
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        notificationCenterTextLabel.text = "Notification Center Test"
        delegateTextLabel.text = "Delegate Test"
        closureTextLabel.text = "Closure Test"
        
        notificationCenterTextField.placeholder = "Notification Center Placeholder"
        notificationCenterTextField.textAlignment = .center
        notificationCenterTextField.autocorrectionType = .no
        delegateTextField.placeholder = "Delegate Placeholder"
        delegateTextField.textAlignment = .center
        delegateTextField.autocorrectionType = .no
        closureTextField.placeholder = "Closure Placeholder"
        closureTextField.textAlignment = .center
        closureTextField.autocorrectionType = .no
        
        sendButton.setTitle("Send", for: .normal)
        
        notificationCenterTextField.layer.borderWidth = 0.5
        notificationCenterTextField.layer.cornerRadius = 10
        delegateTextField.layer.borderWidth = 0.5
        delegateTextField.layer.cornerRadius = 10
        closureTextField.layer.borderWidth = 0.5
        closureTextField.layer.cornerRadius = 10
        
        closureTextField.addTarget(self, action: #selector(self.textFieldDidChange),
                                  for: .editingChanged)
        sendButton.addTarget(self, action: #selector(self.sendButtonTapped), for: .touchUpInside)
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        NSLayoutConstraint.activate(sharedConstraints)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        layoutTrait(traitCollection: traitCollection)
    }
    
    /// Sets TextField text when input comes
    /// - Parameter sender: UITextField
    @objc func textFieldDidChange(sender: UITextField) {
        closureTextField.text = sender.text
        
    }
    /// Makes the transition to SecondViewController
    /// - Parameter sender: UIButton
    @objc func sendButtonTapped(sender : UIButton) {
        // Make instance from SecondViewController
        let secondVC = SecondViewController()
        // No Parameter, return information to second View Controller
        secondVC.completionHandler = { self.closureTextField.text ?? "" }
        
        secondVC.modalPresentationStyle = .fullScreen
        // ViewController transition
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    


}


