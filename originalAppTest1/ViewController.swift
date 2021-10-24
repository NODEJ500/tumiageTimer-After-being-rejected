



import UIKit
import Lottie

class ViewController: UIViewController {
    
    var timer:Timer!
    var time:Int = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    }
    @IBAction func startButtonAction(_ sender: UIButton!) {
        //タイマーボタンが押された時、ボタンタイトルをストップにする
        if  timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            sender.setTitle("ストップ", for: .normal)
            showAnimation()
        }else{
            timer.invalidate()
            timer = nil
            sender.setTitle("スタート", for: .normal)
            stopAnimation()
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
        time = 0
   }
    @IBAction func twitterShareButton(_ sender: Any) {
        //Twitter投稿画面を開く
        if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
            // Twitter公式アプリがインストールされている場合
            let countmin = time / 60
            let text = "今日の積み上げ\n\(countmin)分\n\n\n\n\n\n#今日の積み上げ"
            let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let encodedText = encodedText,let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            // Twitter公式アプリがインストールされていない場合
            let url = NSURL(string: "https://twitter.com/")
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    //アニメーション
    func showAnimation() {
        let animationView = AnimationView(name: "Animation")
        animationView.center = self.view.center
        animationView.frame = CGRect(x: 0, y: -150, width: view.frame.size.width / 2, height: view.frame.size.height / 2)
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        view.addSubview(animationView)
        animationView.play()
    }
    func stopAnimation() {
        let animationView = AnimationView(name: "Animation")
        animationView.stop()
        view.addSubview(animationView)
    }
}
