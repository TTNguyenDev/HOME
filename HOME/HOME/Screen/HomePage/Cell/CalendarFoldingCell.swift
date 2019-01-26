//
//  CalendarFoldingCell.swift
//  HOME
//
//  Created by TT Nguyen on 1/22/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

import UIKit
import FoldingCell
import Charts

class CalendarFoldingCell: FoldingCell {
    
    
    @IBOutlet weak var mToday: UILabel!
    @IBOutlet weak var mDaysLeft: UILabel!
    
    @IBOutlet var mPieChartContainerView: PieChartView!
    
    var mDayLeftValueForChart = PieChartDataEntry(value: Double(Date.daysLeft()))
    var mDaysOfMonth = PieChartDataEntry(value: 31 -  Double(Date.daysLeft()))
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        
        presentData()
        
        numberOfDownloadsDataEntries = [mDayLeftValueForChart, mDaysOfMonth]
        updateChartData()
    }
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(values: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        

        chartDataSet.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0, green: 0.9596373439, blue: 0.5107159019, alpha: 1)]
        
        mPieChartContainerView.data = chartData
        
        
    }
    
    
    func presentData() {
        mDaysLeft.text = String(Date.daysLeft()) +  " days left"
        mToday.text = "Today: " + Date.getCurrentDate()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:FoldingCell.AnimationType)-> TimeInterval {
        let durations = [0.33, 0.26, 0.26] 
        return durations[itemIndex]
    }
    
    
}
