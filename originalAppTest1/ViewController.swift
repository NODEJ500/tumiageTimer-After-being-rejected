



import UIKit
import Lottie

class ViewController: UIViewController {
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    var timermove = false
    var suspend = false
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButtonVar: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let buttonTitle = startButtonVar.currentTitle
       
    }
    
    @IBAction func startButtonAction(_ sender: UIButton!) {
        
        // let buttonTitle = self.startButtonVar.currentTitle
        
        if  timermove == false {
            self.startTime = Date.timeIntervalSinceReferenceDate
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            timermove = true
            sender.setTitle("ストップ", for: .normal)
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)

    }
    @objc func timerCounter() {
        guard let startTime = self.startTime else { return }
        let time = Date.timeIntervalSinceReferenceDate - startTime
        let min = Int(time / 60)
        let sec = Int(time) % 60
        let msec = Int((time - Double(sec)) * 100.0)
        self.timerLabel.text = String(format: "%02d:%02d:%02d", min, sec, msec)
    }
    
    @IBAction func resetButtonAction(_ sender: Any){
        
        if timermove == false {
            self.startTime = nil
            timer.invalidate()
            self.timerLabel.text = "00:00:00"
       }
    }
    
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
