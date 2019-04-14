//
//  OnboardingViewController.swift
//  NOSDriver
//
//  Created by Ian Manor on 14/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, Storyboarded {
    @IBOutlet weak var descriptionLabel: UILabel!
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = descriptionText
    }
    
    @IBAction func skipOnboarding(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootViewController(LoginNavigationController.instantiate())
    }
}
