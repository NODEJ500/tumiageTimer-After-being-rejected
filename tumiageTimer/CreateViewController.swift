//
//  CreateViewController.swift
//  tumiageTimer
//
//  Created by Jun on 2021/12/04.
//

import UIKit
import RealmSwift

class CreateViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //日付ピッカー設定
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        datePicker.preferredDatePickerStyle = .wheels
        
        //日付決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //分数決定バーの生成
        let minutestoolbar = UIToolbar()
        let minutesspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let minutesdone = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(didTapDoneButton))
        minutestoolbar.items = [minutesspace,minutesdone]
        minutestoolbar.sizeToFit()
        minutesTextField.inputAccessoryView = minutestoolbar
        
        // インプットビュー設定
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func done() {
        dateTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = "\(formatter.string(from: Date()))"
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        
        //dateTextFieldが空だった場合ダイアログを出す
        if dateTextField.text == "" {
            let dialog = UIAlertController(title: "日付を入力してください", message: nil, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
            
            //minutesTextFieldが空だった場合ダイアログを出す
        } else if minutesTextField.text == "" {
            let dialog = UIAlertController(title: "時間を入力してください", message: nil, preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        } else {
            //RecordModelをインスタンス化
            let recordModel:RecordModel = RecordModel()
            
            recordModel.data = self.dateTextField.text
            recordModel.memo = self.minutesTextField.text! + "分"
            
            //Realmデータベースを取得
            let realm = try! Realm()
            try! realm.write {
                realm.add(recordModel)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func didTapDoneButton(){
        minutesTextField.resignFirstResponder()
        
    }
    //textField以外をタップでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
