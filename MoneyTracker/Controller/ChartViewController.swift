//
//  ChartViewController.swift
//  MoneyTracker
//
//  Created by sushen satturu on 18/7/18.
//  Copyright © 2018 Sushen Satturu. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    var accountsDataModelArray : [TransactionDataModel]?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChart(forAccount: accountsDataModelArray![0])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- buttons
    @IBAction func accButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if(tag >= 0 && tag <= 3) {
            let account = accountsDataModelArray![tag]
            setupChart(forAccount: account)
        }
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    //MARK:- set up chart
    func setupChart(forAccount acc : TransactionDataModel) {
        setupChart(xAxisValues: acc.dateArray, yAxisValues: acc.moneyArray)
    }
    
    
    func setupChart(xAxisValues : [Date], yAxisValues : [Double]) {
        
        var dataEntries : [ChartDataEntry] = [ChartDataEntry]()
        
        for item in 0..<yAxisValues.count {
            
            //let timeSincePreviousPoint = DateInterval(start: xAxisValues[0], end: xAxisValues[item])
            var xval = xAxisValues[item].timeIntervalSince1970
            xval = xval / 86400
            
            
            let dataEntry : ChartDataEntry = ChartDataEntry(x: xval, y: yAxisValues[item])
            dataEntries.append(dataEntry)
            
        }
        
        setupXaxis()
        
        let dataSet = LineChartDataSet(values: dataEntries, label: "money")
        let chartData = LineChartData(dataSet: dataSet)
        
        lineChartView.data = chartData
        
        
    }
    
    func setupXaxis() {
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        
        // xAxis.axisMaximum = 5
        xAxis.labelCount = 4
        
        //xAxis.valueFormatter = NewXAxisFormatter()
        
        
    }
    
    
}
