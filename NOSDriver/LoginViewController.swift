//
//  ViewController.swift
//  NOSDriver
//
//  Created by Ian Manor on 13/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, Storyboarded {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    @IBAction func login(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootViewController(MainViewController.instantiate())
    }
}
