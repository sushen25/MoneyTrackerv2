//
//  ViewController.swift
//  MoneyTracker
//
//  Created by sushen satturu on 1/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func specificButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSpecifics", sender: self)
        
    }
    
}

