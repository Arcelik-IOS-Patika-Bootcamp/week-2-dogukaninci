//
//  SecondViewController.swift
//  week-2-dogukaninci
//
//  Created by Doğukan Inci on 26.05.2022.
//

import UIKit

class SecondViewController: UIViewController, MyDataSendingDelegateProtocol {

    private var notificationCenterTextLabel = UILabel()
    private var delegateTextLabel = UILabel()
    private var closureTextLabel = UILabel()
    
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
    /// Adds subviews to the main view controller
    private func addViews() {
        view.addSubview(notificationCenterTextLabel)
        view.addSubview(delegateTextLabel)
        view.addSubview(closureTextLabel)
    }
    /// Sets layouts
    private func setupLayout() {
        notificationCenterTextLabel.translatesAutoresizingMaskIntoConstraints = false
        delegateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        closureTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notificationCenterTextLabel.textAlignment = .left
        delegateTextLabel.textAlignment = .left
        closureTextLabel.textAlignment = .left
        
        
        sharedConstraints.append(contentsOf: [
            notificationCenterTextLabel.heightAnchor.constraint(equalToConstant: 44),
            notificationCenterTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            notificationCenterTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            notificationCenterTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            delegateTextLabel.heightAnchor.constraint(equalToConstant: 44),
            delegateTextLabel.topAnchor.constraint(equalTo: notificationCenterTextLabel.bottomAnchor, constant: 10),
            delegateTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            delegateTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            closureTextLabel.heightAnchor.constraint(equalToConstant: 44),
            closureTextLabel.topAnchor.constraint(equalTo: delegateTextLabel.bottomAnchor, constant: 10),
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
    
    // Delegate Method
    func sendDataToSecondViewController(myData: String) {
        self.delegateTextLabel.text = "delegate -> \(myData)"
    }
    
    private func setViewDetails() {
        view.backgroundColor = .white
        
        // writes the data returning from the closure to the text
        closureTextLabel.text = "closure -> \(completionHandler!())"
        
        //Assigns delegate to self
        let firstVC = FirstViewController()
        firstVC.delegate = self
        
    }
    
    @objc func dissmissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
