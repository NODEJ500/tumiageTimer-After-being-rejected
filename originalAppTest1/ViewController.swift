



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
            
        if  timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            sender.setTitle("ストップ", for: .normal)
        }else{
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
        self.timerLabel.text = String(format: "%02d:%02d", hour, min, sec)
    }
    
    @IBAction func resetButtonAction(_ sender: Any){
        
        if timer != nil{
            timer.invalidate()
            timer = nil
        }
        self.timerLabel.text = "00:00:00"
        time = 0
   }
    //アニメーション
    func showAnimation() {
        let animationView = AnimationView(name: "Animation")
        animationView.center = self.view.center
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        view.addSubview(animationView)
        animationView.play()
    }
}
