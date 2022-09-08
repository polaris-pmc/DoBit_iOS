//
//  AuthMainViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/24.
//

import UIKit

class AuthMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    @IBAction func signupTapped(_ sender: Any) {
        performSegue(withIdentifier: "showSignupView", sender: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        performSegue(withIdentifier: "showLoginView", sender: nil)
    }
}
