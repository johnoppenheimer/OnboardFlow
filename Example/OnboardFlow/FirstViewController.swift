//
//  FirstViewController.swift
//  OnboardFlow_Example
//
//  Created by Maxime Cattet on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import OnboardFlow

class FirstViewController: UIViewController, OnboardFlowCompletableController {
    weak var completableDelegate: OnboardFlowCompletableViewControllerDelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "FirstViewController"
        label.textAlignment = .center
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                label.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
                
                button.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -100),
                button.widthAnchor.constraint(equalToConstant: 100),
                button.heightAnchor.constraint(equalToConstant: 30)
            ]
        )
        
        button.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
    }
    
    @objc func next(_ sender: Any) {
        completableDelegate?.done(controller: self)
    }
}
