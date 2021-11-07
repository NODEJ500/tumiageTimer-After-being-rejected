



import UIKit

class ViewController: UIViewController,backgroundTimerDelegate {
   
    
    var timerIsBackground = false
    var timer:Timer!
    var time:Int = 0
    
    
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var resetButtonLabel: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //スタートボタンのデザイン設定
        startButtonLabel.layer.cornerRadius = 10
        startButtonLabel.layer.shadowOpacity = 0.7
        startButtonLabel.layer.shadowRadius = 3
        startButtonLabel.layer.shadowColor = UIColor.black.cgColor
        startButtonLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        //リセットボタンのデザイン設定
        resetButtonLabel.layer.cornerRadius = 10
        resetButtonLabel.layer.shadowOpacity = 0.7
        resetButtonLabel.layer.shadowRadius = 3
        resetButtonLabel.layer.shadowColor = UIColor.black.cgColor
        resetButtonLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        //タイマーラベルのデザイン設定
        timerLabel.layer.cornerRadius = 10
        timerLabel.clipsToBounds = true
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                   return
        }
        sceneDelegate.delegate = self
    }
    @IBAction func startButtonAction(_ sender: UIButton!) {
        //スタートボタンが押された時、タイマーが起動していなければタイマーを起動して、ボタンタイトルをストップにする
        if  timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            startButtonLabel.setTitle("ストップ", for: .normal)
        //ストップボタンが押された時、タイマーを破棄し、ボタンタイトルをスタートに戻す
        } else {
            timer.invalidate()
            timer = nil
            sender.setTitle("スタート", for: .normal)
        }
    }
    @objc func timerCounter() {
        time += 1
        let hour = Int(time / 3600)
        let min = Int(time - (hour * 3600)) / 60
        let sec = Int(time) % 60
        self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        self.timerLabel.text = "00:00:00"
        startButtonLabel.setTitle("スタート", for: .normal)
        time = 0
   }
    @IBAction func twitterShareButton(_ sender: Any) {
        
        //タイマーが停止しているかつtimeの値が60以上である場合
        if timer == nil && time >= 60 {
            
            //Twitter投稿画面を開く
            if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
                // Twitter公式アプリがインストールされている場合
                let countmin = time / 60
                let text = "今日の積み上げ\n\(countmin)分\n\n\n\n\n\n#今日の積み上げ"
                let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    if let encodedText = encodedText,let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        timerIsBackground = false
                    }
            } else {
                // Twitter公式アプリがインストールされていない場合
                let url = NSURL(string: "https://twitter.com/")
                if UIApplication.shared.canOpenURL(url! as URL) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                }
              }
                } else if time <= 60 {
                    let dialog1 = UIAlertController(title: "1分以上積み上げてからツイートしましょう！", message: nil, preferredStyle: .alert)
                    dialog1.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
                    self.present(dialog1, animated: true, completion: nil)
            
                } else {
                    let dialog2 = UIAlertController(title: "タイマーを停止してからツイートしてください。", message: nil, preferredStyle: .alert)
                    dialog2.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
                    self.present(dialog2, animated: true, completion: nil)
                }
    }
    
    func setCurrentTimer(_ elapsedTime: Int) {
        time += elapsedTime
        let hour = Int(time / 3600)
        let min = Int(time - (hour * 3600)) / 60
        let sec = Int(time) % 60
        self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, min, sec)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    func checkBackground() {
        //バックグラウンドへの移行を確認
        if let _ = timer {
        timerIsBackground = true
        }
    }
    
    func deleteTimer() {
        if let _ = timer {
           timer.invalidate()
       }
    }
}
