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
    var labels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let realm = try! Realm()
        
        //（Realmからデータを取得してグラフに表示）
        realmdata = realm.objects(RecordModel.self)
        
        for i in realmdata {
            timearray.append(i.charttime)
        }
        
        for i in realmdata {
            datearray.append(i.date!)
        }
        
        for i in realmdata {
            labels.append(i.date!)
        }
        
        let entries = timearray.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
        
        let dataSet = BarChartDataSet(entries: entries)
        
        let data = BarChartData(dataSet: dataSet)
        
        barChartView.data = data
        
        //ラベルに表示するデータを指定　上で作成した「labels」を指定
        print("labels: \(labels)")
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        
        barChartView.xAxis.granularity = 1
        
        // ラベルの数を設定
        barChartView.xAxis.labelCount = 7
        
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
        dataSet.colors = [UIColor(red: 0, green: 0.96, blue: 0.81, alpha: 1.0)]
        //凡例を非表示
        barChartView.legend.enabled = false
        //グラフのアニメーション
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)
    }
}
