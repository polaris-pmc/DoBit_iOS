//
//  UITextField+Extension.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/14.
//

import UIKit

extension UITextField {
    
    // return key 입력 시 다음 TextField로, 마지막 TextField에서는 keyboard 사라짐
    class func connectAllTextFields(textFields: [UITextField]) -> Void {
        guard let last = textFields.last else {
            return
        }
        
        for i in 0 ..< textFields.count - 1 {
            textFields[i].returnKeyType = .next
            textFields[i].addTarget(textFields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    // MARK:- style
    func setLeftPadding(width: CGFloat = 1.0) {
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: self.frame.height))
        
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorder() {
        
        self.setLeftPadding()
        self.font = UIFont.fontKorean()
        self.textColor = UIColor.appColor(.DoBitBlack)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 12, width: self.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.appColor(.DarkGrey).cgColor
        
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    // MARK:- managing subviews
    func printErrorMessage(message: String) {
        if let label = self.viewWithTag(400) {
            label.removeFromSuperview()
        }
        
        let errorLabel = UILabel(frame: CGRect(x: 0.0, y: self.frame.height + 7, width: self.frame.width, height: 16))
        errorLabel.text = message
        errorLabel.font = UIFont.fontKorean(size: .description)
        errorLabel.textColor = UIColor.appColor(.DoBitRed)
        errorLabel.tag = 400
        
        self.addSubview(errorLabel)
    }
    
    func removeErrorMessage() {
        if let label = self.viewWithTag(400) {
            label.removeFromSuperview()
        }
    }
}

extension UIViewController: UITextFieldDelegate {
    
//     글자가 입력되었을 때 기준으로 bottom line color 변경
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let bottomLine = textField.layer.sublayers?.first {
            if range.location == 0 && range.length == 1 {
                // textField의 마지막 글자가 지워졌을 때
                textField.textColor = UIColor.appColor(.DarkGrey)
                bottomLine.backgroundColor = UIColor.appColor(.DarkGrey).cgColor
            } else if (range.location == 0 && !string.isEmpty) {
                // textField가 비었는데, 문자가 입력되었을 때
                textField.textColor = UIColor.appColor(.DoBitBlack)
                bottomLine.backgroundColor = UIColor.appColor(.DoBitBlack).cgColor
            }
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
