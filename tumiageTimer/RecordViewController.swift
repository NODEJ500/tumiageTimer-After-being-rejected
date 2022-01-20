//
//  RecordViewController.swift
//  tumiageTimer
//
//  Created by Jun on 2021/12/04.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var recordList: Results<RecordModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //Realmをインスタンス化
        let realm = try! Realm()
        //Realmデータベースに登録されているデータを全て取得
        self.recordList = realm.objects(RecordModel.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recordList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if recordList.count != 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let record:RecordModel = self.recordList[(indexPath as NSIndexPath).row]
            cell.textLabel?.text = record.time
            cell.detailTextLabel?.text = record.date
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "本当に削除しますか？",message: nil ,preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "はい", style: .default, handler: { action in
                //Realmから選択したデータを削除
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(self.recordList[indexPath.row])
                    //tableViewからデータを削除
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }}))
            alert.addAction(UIAlertAction(title: "いいえ", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
