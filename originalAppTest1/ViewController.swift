



import UIKit
import EAIntroView

class ViewController: UIViewController,backgroundTimerDelegate,EAIntroDelegate {
   
    
    var timerIsBackground = false
    var timer:Timer!
    var time:Int = 0
    
    
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var resetButtonLabel: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var twitterButtun: UIButton!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setup()
        
        twitterButtun.imageView?.contentMode = .scaleAspectFit
        twitterButtun.contentHorizontalAlignment = .fill
        twitterButtun.contentVerticalAlignment = .fill
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
            startButtonLabel.setTitle("STOP", for: .normal)
        //ストップボタンが押された時、タイマーを破棄し、ボタンタイトルをスタートに戻す
        } else {
            timer.invalidate()
            timer = nil
            sender.setTitle("START", for: .normal)
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
        startButtonLabel.setTitle("START", for: .normal)
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
    func setup() {
       
        let visit = UserDefaults.standard.bool(forKey: "visit")
        
        if visit {
            //二回目以降
            print("二回目以降")
        } else {
            //初回アクセス
            print("初回起動")
            UserDefaults.standard.set(true, forKey: "visit")
            
            let page1 = EAIntroPage()
            //背景色変更
            page1.bgColor = UIColor {_ in return #colorLiteral(red: 0, green: 0.9824101329, blue: 0.8031120896, alpha: 1)}
            //タイトルのテキスト
            page1.title = "ダウンロードありがとうございます！"
            //タイトルの色変更
            page1.titleColor = UIColor {_ in return #colorLiteral(red: 0, green: 0.5058823529, blue: 0.8117647059, alpha: 1)}
            //タイトルのフォントの設定
            page1.titleFont = UIFont(name: "Arial", size: 32)
             
            //テキストの位置を変更
            page1.titlePositionY = self.view.bounds.size.height/2
            
            let page2 = EAIntroPage()
            //画像の設定
            page2.bgImage = UIImage(named: "SC2")
            
            let page3 = EAIntroPage()
            //画像の設定
            page3.bgImage = UIImage(named: "SC3")
            //ここでページを追加
            let introView = EAIntroView(frame: self.view.bounds, andPages: [page1, page2, page3])
            //スキップボタンのテキスト
            introView?.skipButton.setTitle("SKIP", for: UIControl.State.normal)
            //スキップボタンの色変更
            introView?.skipButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
             
            introView?.delegate = self
            //アニメーション設定
            introView?.show(in: self.view, animateDuration: 0.5)
        }
    }
}
