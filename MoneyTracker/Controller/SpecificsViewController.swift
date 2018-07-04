//
//  SpecificsViewController.swift
//  MoneyTracker
//
//  Created by sushen satturu on 1/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import UIKit

protocol SpecificViewControllerDelegate {
    func getTotalAmount(totalAmountMoney : Int, moneyAccountArray : [Int])
}

class SpecificsViewController: UIViewController, ChangeViewControllerDelegate {
    
    var delegate : SpecificViewControllerDelegate?
    
    // MARK: - user interface variables
    
    @IBOutlet var accountLables: [UILabel]!
    @IBOutlet var moneyLables: [UILabel]!
    var moneyInAccounts : [Int] = [Int]()
    
    
    
    @IBOutlet var progressBars: [UIView]!
    @IBOutlet weak var progressBarBackground: UIView!
    @IBOutlet var progressBarWidthArray: [NSLayoutConstraint]!
    
    
    var senderAcc : Int = 0 // var used to tell 'prepare for segue' which acc to process
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set initial values of accounts
        accountLables[0].text = "CAH"
        accountLables[1].text = "USD"
        accountLables[2].text = "CSH"
        accountLables[3].text = "ACC"
        
        
        for item in 1...progressBars.count + 1 {
            print(item)
            setMoneyLable(sectionNo: item)
            setProportionalWidthOfBar(account: item)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Buttons
    @IBAction func accountButtonPressed(_ sender: UIButton) {
        
        senderAcc = sender.tag
        // prepare for segue
        performSegue(withIdentifier: "goToChangeScreen", sender: self)
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.getTotalAmount(totalAmountMoney: self.sumOfArray(array: self.moneyInAccounts), moneyAccountArray: self.moneyInAccounts)
        }
    }
    
    
    
    
    //MARK: - preparing for segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToChangeScreen") {
            //set up preperation here
            let changeViewController = segue.destination as! ChangeViewController
            
            changeViewController.delegate = self
            
            changeViewController.accName = accountLables[senderAcc - 1].text!
            changeViewController.accNumber = senderAcc
            changeViewController.moneyInAccount = moneyInAccounts[senderAcc - 1]
            
            
        }
    }
    
    func accountChanged(accountNumber: Int, newMoneyAmount: Int) {
        
        // resetting the array
        moneyInAccounts[accountNumber - 1] = newMoneyAmount
        
        viewDidLoad()
        
        
    }
    
    
    // MARK: - mutators to change ui elements
    
    // set width of the progress bar for a particular section
    func setWidthOfBar(sectionNo : Int, setWidth : Double) {
        
        //section numbers start from 1 to end
        
        if (setWidth > 0) {
            progressBarWidthArray[sectionNo - 1].constant = CGFloat(setWidth)
            
        }
        self.view.layoutIfNeeded()
        
    }
    
    
    func setMoneyLable(sectionNo : Int) {
        if(sectionNo >= 1 && sectionNo <= 4) {
        let moneyLable = moneyLables[sectionNo - 1]
        let amount = moneyInAccounts[sectionNo - 1]
        
        
        moneyLable.text = "$\(amount)"
            
        }
        
    }
    
    func setProportionalWidthOfBar(account : Int) {
        let totalMoney : Int = sumOfArray(array: moneyInAccounts)
        let widthOfTotalBar = Double(progressBarBackground.frame.width)
        let amountOfAccount = moneyInAccounts[account - 1]
        
        let percentOfProgressBar : Double = Double(amountOfAccount)/Double(totalMoney)
        
        setWidthOfBar(sectionNo: account, setWidth: percentOfProgressBar * widthOfTotalBar)
        
    }
    
    
    func sumOfArray(array : [Int]) -> Int {
        var sum = 0
        
        for item in array {
            sum += item
        }
        
        return sum
        
    }

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
