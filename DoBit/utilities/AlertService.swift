//
//  AlertService.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/05.
//

import UIKit

struct AlertService {
    
    static func showAlert(_ title: String, _ message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        return alertController
    }
    
    static func showError(_ error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: "오류", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}

// self.showAlert(ErrorAlert.makeErrorAlert(error))
extension UIViewController {
    func showAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }
}
