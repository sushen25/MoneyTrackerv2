//
//  TransactionDataModel.swift
//  MoneyTracker
//
//  Created by sushen satturu on 18/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import Foundation

class TransactionDataModel {
    
    var moneyArray : [Double] = [Double]()
    var dateArray : [Date] = [Date]()
    
    func getCurrentMoneyAmount() -> Int {
        var amount : Double = 0
        if(moneyArray.count > 0) {
            amount = moneyArray[moneyArray.count - 1]
        }
        
        return Int(amount)
        
    }

    
}
