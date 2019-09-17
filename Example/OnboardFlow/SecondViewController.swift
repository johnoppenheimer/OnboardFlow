//
//  SecondViewController.swift
//  OnboardFlow_Example
//
//  Created by Maxime Cattet on 17/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import OnboardFlow

class SecondViewController: UIViewController, OnboardFlowCompletableController {
    var delegate: OnboardFlowCompletableViewControllerDelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "SecondViewController"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                label.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
            ]
        )
    }
}
