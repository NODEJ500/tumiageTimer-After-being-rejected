



import UIKit
import Lottie

class ViewController: UIViewController {
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    var timermove = false
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        
        if timermove == false {
            timer.invalidate()
            self.startTime = Date.timeIntervalSinceReferenceDate
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            timermove = true
            showAnimation()
        
        }
    }
    @objc func timerCounter() {
        guard let startTime = self.startTime else { return }
        let time = Date.timeIntervalSinceReferenceDate - startTime
        let min = Int(time / 60)
        let sec = Int(time) % 60
        let msec = Int((time - Double(sec)) * 100.0)
        self.timerLabel.text = String(format: "%02d:%02d:%02d", min, sec, msec)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        
        if timermove == true {
            timer.invalidate()
            timermove = false
            
            
        }
    
    }
    
    @IBAction func resetButtonAction(_ sender: Any){
        
        if timermove == false {
            self.startTime = nil
            self.timerLabel.text = "00:00:00"
       }
    }
    
    func showAnimation() {
        
        let animationView = AnimationView(name: "Animation")
        animationView.layer.position = CGPoint(x: 0, y: 0)
        animationView.center = self.view.center
        animationView.loopMode = .loop
        animationView.animationSpeed = 2.5
        view.addSubview(animationView)
        animationView.play()
    
    }
}
