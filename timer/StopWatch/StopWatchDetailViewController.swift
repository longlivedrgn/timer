//
//  StopWatchDetailViewController.swift
//  timer
//
//  Created by 김용재 on 2022/08/08.
//

import UIKit

class StopWatchDetailViewController: UIViewController {

    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var hoursTextField: UITextField!
    
    @IBOutlet weak var minutesTextField: UITextField!
    
    @IBOutlet weak var SecondsTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
//        hoursTextField.delegate = self
//        minutesTextField.delegate = self
//        SecondsTextField.delegate = self
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "StopWatch", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "StopWatchViewController") as! StopWatchViewController
        
        if let hourvalue = Int(hoursTextField.text!), let minutevalue = Int(minutesTextField.text!), let secondvalue = Int(SecondsTextField.text!){
            vc.dataFromFirstHours = hourvalue
            vc.dataFromFirstMinutes = minutevalue
            vc.dataFromFirstSeconds = secondvalue
        } else {
            vc.dataFromFirstHours = 0
            vc.dataFromFirstSeconds = 0
            vc.dataFromFirstMinutes = 0
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StopWatchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let charSet: CharacterSet = {
            var cs = CharacterSet.lowercaseLetters
            cs.insert(charactersIn: "0123456789")
            cs.insert(charactersIn: "-")
            return cs.inverted
        }()

        
        if string.count > 0 {
            guard string.rangeOfCharacter(from: charSet) == nil else{
                return false
            }
        }
        return true
    }
}




