//
//  ConfigurationTableViewController.swift
//  NOSDriver
//
//  Created by Ian Manor on 13/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import UIKit

class ConfigurationTableViewController: UITableViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootViewController(LoginNavigationController.instantiate())
    }
    
}
