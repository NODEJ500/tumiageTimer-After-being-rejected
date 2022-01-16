//
//  ChartsViewController.swift
//  tumiageTimer
//
//  Created by Jun on 2021/12/25.
//

import UIKit
import RealmSwift
import Charts

class ChartsViewController: UIViewController {

    
    @IBOutlet weak var barChartView: BarChartView!
    
    var realmdata: Results<RecordModel>!
    //グラフで使う配列
    var timearray: [Double] = []
    var datearray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let realm = try! Realm()
        
        //（Realmからデータを取得してグラフに表示）
        realmdata = realm.objects(RecordModel.self)
        
        for i in realmdata {
            timearray.append(i.charttime)
        }
        
        for i in realmdata {
            datearray.append(i.date!)
        }
        
        var entries = [BarChartDataEntry]()
        
        for i in 0..<realmdata.count {
            entries.append(BarChartDataEntry(x: Double(timearray[i]), y: Double(timearray[i])))
        }
        print(entries)

        
        //let entries = timearray.enumerated().map { BarChartDataEntry(x: Double($0.element), y: Double($0.element)) }
        
        let dataSet = BarChartDataSet(entries: entries)
        
        let data = BarChartData(dataSet: dataSet)
        
        barChartView.data = data
        
        // X軸のラベルの位置を下に設定
        barChartView.xAxis.labelPosition = .bottom
        // X軸のラベルの色を設定
        barChartView.xAxis.labelTextColor = .systemGray
        // X軸の線、グリッドを非表示にする
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        // 右側のY座標軸は非表示にする
        barChartView.rightAxis.enabled = false
        
        // Y座標の値が0始まりになるように設定
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.drawZeroLineEnabled = true
        barChartView.leftAxis.zeroLineColor = .systemGray
        // ラベルの数を設定
        barChartView.leftAxis.labelCount = 5
        // ラベルの色を設定
        barChartView.leftAxis.labelTextColor = .systemGray
        // グリッドの色を設定
        barChartView.leftAxis.gridColor = .systemGray
        // 軸線は非表示にする
        barChartView.leftAxis.drawAxisLineEnabled = false
        //データの値を非表示
        dataSet.drawValuesEnabled = false
        //グラフの色を変更
        dataSet.colors = [.blue]
        //判例を非表示
        barChartView.legend.enabled = false
        //グラフのアニメーション
        //barChart.animate(xAxisDuration: 2.5, yAxisDuration: 2.5, easingOption: .linear)
        

       
    }

}
