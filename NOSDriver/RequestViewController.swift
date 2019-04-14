//
//  RequestViewController.swift
//  NOSDriver
//
//  Created by Ian Manor on 13/04/19.
//  Copyright © 2019 Ian Manor. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController, Storyboarded {
    var request: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = request
    }
    
    @IBAction func acceptRequest(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rejectRequest(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
