//
//  GoalChartTableViewCell.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

import UIKit
import Charts

class GoalChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var barChartView: BarChartView!
    //    @IBOutlet weak var slider: UISlider!
    
    var x: [Int] = []
    var y: [Double] = []
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLayout(background: UIColor) {
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .fontKorean()
        barChartView.noDataTextColor = .appColor(.DarkGrey)
        
        // 줌 안되게
        barChartView.doubleTapToZoomEnabled = false
    }
    
    func setChart(values: [Float], color: UIColor) {
        let x = [1, 2, 3, 4, 5, 6]
        let y = values
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<x.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(y[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        chartDataSet.colors = [color]
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.legend.enabled = false
        
        barChartView.xAxis.gridColor = .clear
        barChartView.xAxis.axisLineColor = .clear
        barChartView.xAxis.labelTextColor = .clear
        
        barChartView.leftAxis.gridColor = .clear
        barChartView.leftAxis.axisLineColor = .clear
        barChartView.leftAxis.labelTextColor = .clear
        barChartView.leftAxis.zeroLineColor = .clear
        
        barChartView.rightAxis.gridColor = .clear
        barChartView.rightAxis.axisLineColor = .clear
        barChartView.rightAxis.labelTextColor = .clear
        barChartView.rightAxis.zeroLineColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
