//
//  LoginViewController.swift
//  DoBit
//
//  Created by 서민주 on 2021/06/30.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var viewModel: UserViewModel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var textFields: [UITextField]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [emailField, passwordField]
        setUpElements()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpElements() {
        guard let textFields = textFields else {
            return
        }
        
        UITextField.connectAllTextFields(textFields: textFields)
        
        textFields.forEach {
            $0.delegate = self
            $0.setBottomBorder()
        }
        
        passwordResetButton.setFont()
        prevButton.setFont()
        nextButton.setFont()
    }
    
    // MARK:- IBActions
    @IBAction func previousTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        login() { isSuccess in
            if isSuccess {
                self.performSegue(withIdentifier: "showMainView", sender: nil)
            }
        }
    }
    
    // MARK:- login networking
    func login(completed: @escaping (Bool) -> Void) {
        
        guard let email = emailField.text,
              let password = passwordField.text else {
            return
        }
        
        guard !email.isEmpty && !password.isEmpty else {
            if email.isEmpty {
                emailField.printErrorMessage(message: "이메일을 입력해주세요.")
            } else {
                emailField.removeErrorMessage()
            }
            
            if password.isEmpty {
                passwordField.printErrorMessage(message: "비밀번호를 입력해주세요.")
            } else {
                passwordField.removeErrorMessage()
            }
            
            return
        }
        
        textFields?.forEach { $0.removeErrorMessage() }
        
        viewModel.login(email: email, password: password) {
            if let (target, message) = self.viewModel.getErrorMessage() {
                switch target {
                case "email":
                    self.emailField.printErrorMessage(message: message)
                case "password":
                    self.passwordField.printErrorMessage(message: message)
                default: ()
                }
                completed(false)
                return
            }
            completed(true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMainView" {
            let nextView = segue.destination as! RootTabBarController
            nextView.selectedIndex = 1
        }
    }
}
