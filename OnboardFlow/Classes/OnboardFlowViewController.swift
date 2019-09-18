//
//  OnboardFlowViewController.swift
//  OnboardFlow
//
//  Created by Maxime Cattet on 16/09/2019.
//  Copyright © 2019 Maxime Cattet. All rights reserved.
//

import UIKit

public protocol OnboardFlowCompletableController {
    var completableDelegate: OnboardFlowCompletableViewControllerDelegate? { get set }
}

public protocol OnboardFlowCompletableViewControllerDelegate {
    func done(controller: OnboardFlowCompletableViewController)
}

public typealias OnboardFlowCompletableViewController = UIViewController & OnboardFlowCompletableController

public protocol OnboardFlowViewControllerDelegate {
    func finishOnboarding()
}

open class OnboardFlowViewController: UIPageViewController {
    
    // MARK: - Public properties
    public var onboardingDelegate: OnboardFlowViewControllerDelegate?
    
    /// Array of controllers you want in your Onboarding
    public var controllers = [UIViewController]() {
        didSet {
            // Setup delegate for each controllers
            for controller in self.controllers {
                guard var completableController = controller as? OnboardFlowCompletableViewController else {
                    fatalError("Wrong type of controller")
                }
                completableController.completableDelegate = self
            }
            
            self.pageControl.numberOfPages = self.controllers.count
        }
    }
    
    /**
     Set to true if you want to allow user to swipe to navigate.
     
     Default is set to `false`
     */
    public var enableSwipe: Bool = false {
        didSet {
            if self.enableSwipe {
                self.delegate = self
                self.dataSource = self
            } else {
                self.delegate = nil
                self.dataSource = nil
            }
        }
    }
    
    /**
     Tell if you want to show or not the UIPageControl at the bottom.
     
     Default is set to `false`
     */
    public var showPageControl: Bool = false {
        didSet {
            self.pageControl.isHidden = !self.showPageControl
        }
    }
    
    // MARK: - UI
    var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
        control.currentPageIndicatorTintColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.0)
        control.isHidden = true
        return control
    }()
    
    private var pendingIndex = 0
    
    // MARK: - Lifecycle
    public init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                pageControl.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -32)
            ]
        )
        
        // Load the first controllers
        self.setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardFlowViewController: OnboardFlowCompletableViewControllerDelegate {
    public func done(controller: OnboardFlowCompletableViewController) {
        guard let index = self.controllers.firstIndex(of: controller) else {
            fatalError("Error getting index for viewController")
        }
        
        let nextIndex = index + 1
        
        if nextIndex < self.controllers.count {
            self.setViewControllers([self.controllers[nextIndex]], direction: .forward, animated: true, completion: { (_) in
                self.pageControl.currentPage = nextIndex
            })
        } else {
            self.onboardingDelegate?.finishOnboarding()
        }
    }
}

extension OnboardFlowViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = self.controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let prevIndex = pageIndex - 1
        
        guard prevIndex >= 0 && self.controllers.count > prevIndex else {
            return nil
        }
        
        return self.controllers[prevIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pageIndex = self.controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = pageIndex + 1
        
        guard nextIndex < self.controllers.count && self.controllers.count > nextIndex else {
            return nil
        }
        
        return self.controllers[nextIndex]
    }
}

extension OnboardFlowViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let index = self.controllers.firstIndex(of: pendingViewControllers.first!) else {
            return
        }
        
        pendingIndex = index
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.pageControl.currentPage = pendingIndex
    }
}
