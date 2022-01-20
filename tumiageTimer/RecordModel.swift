//
//  RecordModel.swift
//  tumiageTimer
//
//  Created by Jun on 2021/12/04.
//

import Foundation
import RealmSwift

@objcMembers

class RecordModel:Object {
    
    //dynamic var id:Int?
    //時間保存用
    dynamic var time:String?
    //チャートで使う時間保存用
    dynamic var charttime:Double = 0
    //日付保存用
    dynamic var date:String?
    
}
