//
//  KeyboardUtil.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/05.
//

import UIKit

extension UIViewController {
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - self.view.safeAreaInsets.bottom
            
            self.view.frame.origin.y -= keyboardHeight
//            self.view.frame.origin.y -= keyboardHeight - (self.tabBarController?.tabBar.rame.size.height)!
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - self.view.safeAreaInsets.bottom
            
            self.view.frame.origin.y += keyboardHeight
        }

//        self.view.frame.origin.y += (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)!)
    }
}
