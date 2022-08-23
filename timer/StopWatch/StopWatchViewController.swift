//
//  StopWatchViewController.swift
//  timer
//
//  Created by 김용재 on 2022/08/08.
//

import UIKit

class StopWatchViewController: UIViewController {
        
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var miniLabel: UILabel!
    @IBOutlet weak var startstopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var exampleLabel: UILabel!
    
    var dataFromFirstHours : Int = 0
    var dataFromFirstMinutes : Int = 0
    var dataFromFirstSeconds : Int = 0
    
    var timer:Timer = Timer()
    var timeCounting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabelSetUp()
        elseSetUp()
        exampleLabel.layer.masksToBounds = true
        exampleLabel.layer.cornerRadius = 20
    }
    
    private func timeLabelSetUp(){
        self.timeLabel.text = self.makeTimeString(hours: dataFromFirstHours, minutes: dataFromFirstMinutes, seconds: dataFromFirstSeconds)
        timeLabel.layer.cornerRadius = timeLabel.layer.frame.width/2 - 10
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.borderColor = UIColor.orange.adjust(by: abs(15))?.cgColor
        timeLabel.layer.borderWidth = 10
    }
    private func elseSetUp(){
        resetButton.layer.cornerRadius = resetButton.layer.frame.width/2
        startstopButton.layer.cornerRadius = startstopButton.layer.frame.width/2
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        self.timer.invalidate()
        self.timeLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        self.startstopButton.setTitle("시작", for: .normal)
        startstopButton.setTitleColor(UIColor.green, for: .normal)
        startstopButton.backgroundColor = UIColor.green.withAlphaComponent(0.3)
    }

    @IBAction func starstopTapped(_ sender: Any) {
        if(timeCounting)
        {
            timeCounting = false
            miniLabel.textColor = UIColor.gray.withAlphaComponent(0.4)
            timer.invalidate()
            startstopButton.setTitle("재개", for: .normal)
            startstopButton.setTitleColor(UIColor.green, for: .normal)
            startstopButton.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        }
        else {
            timeCounting = true
            miniLabel.textColor = UIColor.gray
            startstopButton.setTitle("일시 정지", for: .normal)
            startstopButton.setTitleColor(UIColor.orange, for: .normal)
            startstopButton.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void{
        dataFromFirstSeconds = dataFromFirstSeconds - 1
        var totalSeconds = (dataFromFirstHours * 3600) + (dataFromFirstMinutes * 60) + dataFromFirstSeconds
        let time = secondsToHoursMinutesSeconds(seconds: totalSeconds)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
}

//extension UIColor {
//    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
//        return self.adjust(by: abs(percentage) )
//    }
//
//    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
//        return self.adjust(by: -1 * abs(percentage) )
//    }
//
//    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
//        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
//            return UIColor(red: min(red + percentage/100, 1.0),
//                           green: min(green + percentage/100, 1.0),
//                           blue: min(blue + percentage/100, 1.0),
//                           alpha: alpha)
//        } else {
//            return nil
//        }
//    }
//
//}


