//
//  ViewController.swift
//  OnboardFlow
//
//  Created by johnoppenheimer on 09/17/2019.
//  Copyright (c) 2019 johnoppenheimer. All rights reserved.
//

import UIKit
import OnboardFlow

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let onboardingController = OnboardFlowViewController()
        onboardingController.controllers = [FirstViewController(), SecondViewController()]
        onboardingController.enableSwipe = false
        onboardingController.showPageControl = true
        
        self.viewControllers = [onboardingController]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

