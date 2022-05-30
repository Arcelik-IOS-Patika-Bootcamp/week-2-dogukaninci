//
//  SecondViewController.swift
//  week-2-dogukaninci
//
//  Created by Doğukan Inci on 26.05.2022.
//

import UIKit

/// Delegate Protocol
protocol MyDataSendingDelegateProtocol: AnyObject {
    func sendDataToFirstViewController(myData: String)
}

class SecondViewController: UIViewController {
    
    weak var delegate: MyDataSendingDelegateProtocol? = nil

    private var notificationCenterTextLabel = UILabel()
    private var delegateTextLabel = UILabel()
    private var closureTextLabel = UILabel()
    private var delegateTextField = UITextField()
    
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    //Completion Variable
    var completionHandler: (() -> String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupLayout()
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        setViewDetails()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Pass data to FirstViewController
        self.delegate?.sendDataToFirstViewController(myData: delegateTextField.text!)
    }
    /// Adds subviews to the main view controller
    private func addViews() {
        view.addSubview(notificationCenterTextLabel)
        view.addSubview(delegateTextLabel)
        view.addSubview(closureTextLabel)
        view.addSubview(delegateTextField)
    }
    /// Sets layouts
    private func setupLayout() {
        notificationCenterTextLabel.translatesAutoresizingMaskIntoConstraints = false
        delegateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        closureTextLabel.translatesAutoresizingMaskIntoConstraints = false
        delegateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        notificationCenterTextLabel.textAlignment = .left
        delegateTextLabel.textAlignment = .left
        closureTextLabel.textAlignment = .left
        
        notificationCenterTextLabel.numberOfLines = 0
        closureTextLabel.numberOfLines = 0
        
        
        sharedConstraints.append(contentsOf: [
            notificationCenterTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            notificationCenterTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            notificationCenterTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            delegateTextLabel.heightAnchor.constraint(equalToConstant: 44),
            delegateTextLabel.topAnchor.constraint(equalTo: notificationCenterTextLabel.bottomAnchor, constant: 10),
            delegateTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            delegateTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            delegateTextField.heightAnchor.constraint(equalToConstant: 44),
            delegateTextField.topAnchor.constraint(equalTo: delegateTextLabel.bottomAnchor, constant: 10),
            delegateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            delegateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            closureTextLabel.topAnchor.constraint(equalTo: delegateTextField.bottomAnchor, constant: 10),
            closureTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            closureTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    func layoutTrait(traitCollection:UITraitCollection) {
        NSLayoutConstraint.activate(sharedConstraints)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        layoutTrait(traitCollection: traitCollection)
    }
    

    /// Set View Details
    private func setViewDetails() {
        view.backgroundColor = .white
        closureTextLabel.textColor = .red
        notificationCenterTextLabel.textColor = .red
        
        delegateTextLabel.text = "Delegate Test: "
        
        delegateTextField.placeholder = "Delegate Placeholder"
        delegateTextField.textAlignment = .center
        delegateTextField.autocorrectionType = .no
        
        delegateTextField.layer.borderWidth = 0.5
        delegateTextField.layer.cornerRadius = 10
        
        delegateTextField.addTarget(self, action: #selector(self.delegateTextFieldDidChange),
                                    for: .editingChanged)
        
        // writes the data returning from the closure to the text
        closureTextLabel.text = "closure -> \(completionHandler!())"
        
        // Notification Center observer adding process
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeNotificationLabel),
                                               name: NSNotification.Name("Notification"),
                                               object: notificationCenterTextLabel.text)
        
    }
    
    /// Sets TextField text when input comes
    /// - Parameter sender: UITextField
    @objc func delegateTextFieldDidChange(sender: UITextField) {
        delegateTextField.text = sender.text
    }
    
    /// Change Notification Label process done after notification
    /// - Parameter notification: NSNotification
    @objc func changeNotificationLabel(notification: NSNotification) {
        notificationCenterTextLabel.text = "Notification Center Text -> \(notification.object as! String)"
    }

}

