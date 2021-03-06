//
//  ViewController.swift
//  MoneyTracker
//
//  Created by sushen satturu on 1/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpecificViewControllerDelegate {

    //instance vars
    var totalMoney : Int = 0
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var totalMoneyLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func specificButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSpecifics", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToSpecifics") {
            
            let specificVC = segue.destination as! SpecificsViewController
            specificVC.delegate = self
            
            
        }
    }
    func getTotalAmount(totalAmountMoney: Int) {
        defaults.set(totalAmountMoney, forKey: "totalMoney")
        
        viewDidLoad()
    }
    
    func updateUI() {
        totalMoneyLable.text = "$\(totalMoney)"
    }
    
    
}

