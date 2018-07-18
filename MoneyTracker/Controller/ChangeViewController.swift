//
//  ChangeViewController.swift
//  MoneyTracker
//
//  Created by sushen satturu on 2/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import UIKit

protocol ChangeViewControllerDelegate {
    func accountChanged(accountNumber : Int, newMoneyAmount : Int)
}

class ChangeViewController: UIViewController {
    
    //Delegate
    var delegate : ChangeViewControllerDelegate?
    
    //UI Elements
    @IBOutlet weak var accountNameLable: UILabel!
    @IBOutlet weak var moneyAmount: UIButton!
    @IBOutlet weak var changeLable: UILabel!
    
    @IBOutlet weak var enterAmount: UIButton!
    
    
    //data elements
    var moneyInAccount : Int = 0
    var accName : String = ""
    var accNumber : Int = 0
    var changeAmount : Int = 0 // variable used to track the amount of money changed
    
    //helper variables
    var arrowChangeAmount : Int = 0
    var moneyTextFieldText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountNameLable.text = accName
        updateUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Buttons
    @IBAction func arrowPressed(_ sender: UIButton) {
        
        let changeConstant : Int = 10
        var textString : String = ""
        enterAmount.isEnabled = false
        
        if(sender.tag == 0) {
            // up arrow pressed
            arrowChangeAmount += changeConstant
            
        } else if (sender.tag == 1) {
            // down arrow pressed
            arrowChangeAmount -= changeConstant
            
        } else if (sender.tag == 2) {
            // ok pressed
            changeAmount += arrowChangeAmount
            moneyInAccount += arrowChangeAmount
            updateUI()
            enterAmount.isEnabled = true
            
            
            arrowChangeAmount = 0
        }
        
        // color of change
        if(arrowChangeAmount > 0) {
            // positive
            moneyAmount.setTitleColor(UIColor.green, for: .normal)
            textString += "+"
        } else if (arrowChangeAmount < 0){
            moneyAmount.setTitleColor(UIColor.red, for: .normal)
        } else {
            moneyAmount.setTitleColor(UIColor.gray, for: .normal)
        }
        
        textString += "\(arrowChangeAmount)"
        if(sender.tag != 2) {
            // only set title is ok button is not pressed
            moneyAmount.setTitle(textString, for: .normal)
        }
        
        
    }
    
    
    
    
    @IBAction func changeAmount(_ sender: UIButton) {
        moneyEnterAlert()
        
    }
    
    @IBAction func canclePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.accountChanged(accountNumber: self.accNumber, newMoneyAmount: self.moneyInAccount)
        }
    }
    
    
    
    //MARK:- functional mathods
    func moneyEnterAlert() {
        let alert = UIAlertController(title: "Change amount in this account", message: "please enter the new money amount", preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            self.moneyTextFieldText = (alert.textFields?[0].text)!
            self.dealWithChangeAmountAlert()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in}
        
        alert.addTextField { (uITextField) in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true) {
            
        }
    }
    
    func dealWithChangeAmountAlert() {
        
        if(isStrNumeric(str: moneyTextFieldText)) {
            let newMoney = Int(moneyTextFieldText)!
            changeAmount += (newMoney - moneyInAccount)
            moneyInAccount = Int(moneyTextFieldText)!
            
            updateUI()
            
            
        } else {
            print("Error bad text field input: \(moneyTextFieldText)")
            let alert = UIAlertController(title: "Bad Input", message: "please enter an integer and try again", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }

        
    }
    
    
    func updateUI() {
        moneyAmount.setTitle("\(moneyInAccount)", for: .normal)
        moneyAmount.setTitleColor(UIColor.gray, for: .normal)
        
        var tempStr = ""
        if(changeAmount > 0) {
            changeLable.textColor = UIColor.green
            tempStr = "+"
        } else if (changeAmount < 0) {
            changeLable.textColor = UIColor.red
        } else {
            changeLable.textColor = UIColor.black
        }
        
        tempStr += "\(changeAmount)"
        changeLable.text = tempStr
        
    }
    
    
    //MARK: - helper functions
    func isStrNumeric(str : String) -> Bool {
        return Int(str) != nil
    }

    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
