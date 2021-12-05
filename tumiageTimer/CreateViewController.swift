//
//  CreateViewController.swift
//  tumiageTimer
//
//  Created by Jun on 2021/12/04.
//

import UIKit

class CreateViewController: UIViewController {
    
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateTextField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        // デフォルト日付
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        datePicker.date = formatter.date(from: "yyyy-MM-dd")!
        
        
    }
    // 決定ボタン押下
    @objc func done() {
        dateTextField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = "\(formatter.string(from: Date()))"
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        
        let recordVC = storyboard?.instantiateViewController(withIdentifier: "RecordVC") as? RecordViewController
        if  let recordVC = recordVC {
            recordVC.memoArray.append(dateTextField.text!)
            present(recordVC,animated: true)
        }
    }
}
