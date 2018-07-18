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
    
    var moneyData : [Double] = [Double]()
    var dateData : [Date] = [Date]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createDummyData()
        setupChart(xAxisValues: dateData, yAxisValues: moneyData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accButtonPressed(_ sender: UIButton) {
        
    }
    
    //MARK:- set up chart
    
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
    
    func createDummyData() {
        
        var currentDate = Date()
        
        for _ in 0..<20 {
            currentDate = Date(timeInterval: 86400, since: currentDate)
            let moneyVal = arc4random_uniform(250) + 100
            
            moneyData.append(Double(moneyVal))
            dateData.append(currentDate)
            
        }
        
    }
    
    
}
