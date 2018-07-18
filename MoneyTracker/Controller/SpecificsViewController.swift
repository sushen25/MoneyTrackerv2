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
    
    // labels
    @IBOutlet var accountLables: [UILabel]!
    @IBOutlet var moneyLables: [UILabel]!
    
    
    // progress bars
    @IBOutlet var progressBars: [UIView]!
    @IBOutlet weak var progressBarBackground: UIView!
    @IBOutlet var progressBarWidthArray: [NSLayoutConstraint]!
    
    //Chart variables tranctions
    var acc1Data = TransactionDataModel()
    var acc2Data = TransactionDataModel()
    var acc3Data = TransactionDataModel()
    var acc4Data = TransactionDataModel()
    
    var accDataArray : [TransactionDataModel] = [TransactionDataModel]()
    
    var senderAcc : Int = 0 // var used to tell 'prepare for segue' which acc to process
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set initial values of accounts
        accountLables[0].text = "CAH"
        accountLables[1].text = "USD"
        accountLables[2].text = "CSH"
        accountLables[3].text = "ACC"
        
        accDataArray = [acc1Data, acc2Data, acc3Data, acc4Data]
        
        
        updateUI()
        
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
            changeViewController.moneyInAccount = accDataArray[senderAcc - 1].getCurrentMoneyAmount()
            
            
        }
    }
    
    // Changed amount of money from change VC
    func accountChanged(accountNumber: Int, newMoneyAmount: Int) {
        
        // resetting the array
        let currentDate = Date()
        let dataModelNo = accDataArray[accountNumber - 1]
        addDataPoint(amountOfMoney: Double(newMoneyAmount), at: currentDate, dataModel: dataModelNo)
        
        
        updateUI()
        
    }
    
    
    // MARK: - mutators to change ui elements
    
    // set width of the progress bar for a particular section
    func setWidthOfBar(accountNo : Int, setWidth : Double) {
        if (setWidth > 0) {
            progressBarWidthArray[accountNo - 1].constant = CGFloat(setWidth)
        }
        
        self.view.layoutIfNeeded()
    }
    
    
    func setMoneyLable(account : Int) {
        if(account >= 1 && account <= 4) {
            let moneyLable = moneyLables[account - 1]
            
            let accDataModel = accDataArray[account - 1]
            let amount = accDataModel.getCurrentMoneyAmount()
        
        
            moneyLable.text = "$\(amount)"
            
        }
        
    }
    
    func setProportionalWidthOfBar(account : Int) {
        let totalMoney : Int = getTotalAmountOfMoney(fromArray: accDataArray)
        let widthOfTotalBar = Double(progressBarBackground.frame.width)
        let amountOfAccount = accDataArray[account - 1].getCurrentMoneyAmount()
        
        let percentOfProgressBar : Double = Double(amountOfAccount)/Double(totalMoney)
        
        setWidthOfBar(accountNo: account, setWidth: percentOfProgressBar * widthOfTotalBar)
        
    }
    
    
    func sumOfArray(array : [Int]) -> Int {
        var sum = 0
        
        for item in array {
            sum += item
        }
        
        return sum
        
    }
    
    func getTotalAmountOfMoney(fromArray arr : [TransactionDataModel]) -> Int {
        var sum = 0
        for i in 0..<arr.count {
            let dataModel = arr[i]
            let moneyInAccount = dataModel.getCurrentMoneyAmount()
            
            sum += moneyInAccount
            
        }
        
        return Int(sum)
        
    }
    
    //MARK:- helper methods
    func addDataPoint(amountOfMoney : Double, at date : Date, dataModel : TransactionDataModel) {
        dataModel.moneyArray.append(amountOfMoney)
        dataModel.dateArray.append(date)
    }
    
    func updateUI() {
        for item in 1...progressBars.count + 1 {
            setMoneyLable(account: item)
            setProportionalWidthOfBar(account: item)
            
        }
    }

 

}
