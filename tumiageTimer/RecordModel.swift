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
    
    
    dynamic var memo:String?
    dynamic var data:String?
    // id をプライマリーキーとして設定
    //override static func primaryKey() -> String? {
    //return "id"
}

