//
//  StopWatchDetailViewController.swift
//  timer
//
//  Created by 김용재 on 2022/08/08.
//

import UIKit

class StopWatchDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var hoursTextField: UITextField!
    
    @IBOutlet weak var minutesTextField: UITextField!
    
    @IBOutlet weak var SecondsTextField: UITextField!
    
    var fCurTextfieldBottom: CGFloat = 0.0
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        hoursTextField.delegate = self
        minutesTextField.delegate = self
        SecondsTextField.delegate = self
        hoursTextField.returnKeyType = .done
        minutesTextField.returnKeyType = .done
        SecondsTextField.returnKeyType = .done
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fCurTextfieldBottom = textField.frame.origin.y + textField.frame.height
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
           if fCurTextfieldBottom <= self.view.frame.height - keyboardSize.height {
               return
           }
           if self.view.frame.origin.y == 0 {
               self.view.frame.origin.y -= keyboardSize.height
           }
       }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        hoursTextField.resignFirstResponder()
        minutesTextField.resignFirstResponder()
        SecondsTextField.resignFirstResponder()
    }
    
    // 토큰 설정하기
    var willShowToken: NSObjectProtocol?
    var willHideToken: NSObjectProtocol?
    
    // 옵져버 해제하기
    deinit {
        if let token = willShowToken {
            NotificationCenter.default.removeObserver(token)
        }
        
        if let token = willHideToken {
            NotificationCenter.default.removeObserver(token)
        }
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



