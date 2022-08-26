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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 현재 선택된 텍스트필드의 아래 꼭지점의 위치 계산하기
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fCurTextfieldBottom = textField.frame.origin.y + textField.frame.height
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
           if fCurTextfieldBottom <= self.view.frame.height - keyboardSize.height {
               // 만약 키보드가 가지지 않으면 return을 통하여 끝냄!
               return
           }
           // 키보드가 가리면 그 만큼 내린다!
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
        
        if let hoursText = hoursTextField.text, !hoursText.isEmpty{
            vc.dataFromFirstHours = Int(hoursText)!
        } else {
            vc.dataFromFirstHours = 0
        }
        
        if let minutesText = minutesTextField.text, !minutesText.isEmpty{
            vc.dataFromFirstMinutes = Int(minutesText)!
        } else {
            vc.dataFromFirstMinutes = 0
        }
        
        if let secondText = SecondsTextField.text, !secondText.isEmpty{
            vc.dataFromFirstSeconds = Int(secondText)!
        } else {
            vc.dataFromFirstSeconds = 0
        }
//
//
//        if let hourvalue = Int(hoursTextField.text ?? "0" ), let minutevalue = Int(minutesTextField.text ?? "0"), let secondvalue = Int(SecondsTextField.text ?? "0"){
//
//            vc.dataFromFirstMinutes = minutevalue
//            vc.dataFromFirstSeconds = secondvalue
//        } else {
//            vc.dataFromFirstHours = 0
//            vc.dataFromFirstSeconds = 0
//            vc.dataFromFirstMinutes = 0
//        }
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



