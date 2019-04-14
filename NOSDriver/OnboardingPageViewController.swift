//
//  OnboardingPageViewController.swift
//  NOSDriver
//
//  Created by Ian Manor on 14/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    lazy var orderedViewControllers: [OnboardingViewController] = {
        let firstViewController = OnboardingViewController.instantiate()
        firstViewController.descriptionText = "Olá"
        
        let secondViewController = OnboardingViewController.instantiate()
        secondViewController.descriptionText = "Notificações"
        
        let thirdViewController = OnboardingViewController.instantiate()
        thirdViewController.descriptionText = "Configurações"
        
        return [
            firstViewController,
            secondViewController,
            thirdViewController
        ]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
}

// MARK: UIPageViewControllerDelegate functions

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController as! OnboardingViewController)!
        print(self.pageControl.currentPage)
    }
}

// MARK: UIPageViewControllerDataSource functions

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController as! OnboardingViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController as! OnboardingViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
