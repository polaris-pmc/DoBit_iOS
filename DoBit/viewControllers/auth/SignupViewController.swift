//
// SignupViewController.swift // DoBit
//
// Created by 서민주 on 2021/06/30.
//
import UIKit

enum TextFieldType: String { case email = "email"
    case password = "password"
    case confirmPassword = "confirmPassword"
    case nickname = "nickname"
}

class SignupViewController: UIViewController {
    @IBOutlet var viewModel: UserViewModel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var textFields: [UITextField]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [emailField, passwordField, confirmPasswordField, nicknameField]
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
        
        prevButton.setFont()
        nextButton.setFont()
    }
    
    // MARK: - IBActions
    @IBAction func previousTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        signUp() { isSuccess in
            if isSuccess { self.performSegue(withIdentifier: "showIdentityView", sender: nil) }
        }
    }
    
    // MARK: - signUp networking
    func signUp(completed: @escaping (Bool) -> Void) {
        guard let email = emailField.text,
              let password = passwordField.text,
              let confirmPassword = confirmPasswordField.text,
              let nickname = nicknameField.text else {
            return
        }
        
        textFields?.forEach { $0.removeErrorMessage() }
        guard !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !nickname.isEmpty else {
            
            if email.isEmpty { handleErrorMessage(of: "email", about: "이메일을 입력해주세요.") }
            if password.isEmpty { handleErrorMessage(of: "password", about: "비밀번호를 입력해주세요.") }
            if confirmPassword.isEmpty { handleErrorMessage(of: "confirmPassword", about: "비밀번호를 한번 더 입력해주세요.") }
            if nickname.isEmpty { handleErrorMessage(of: "nickname", about: "닉네임을 입력해주세요.")
            }
            return
        }
        
        guard password == confirmPassword else {
            handleErrorMessage(of: "confirmPassword", about: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        viewModel.signup(email: email, password: password, confirmPassword: confirmPassword, nickname: nickname) {
            guard let (target, message) = self.viewModel.getErrorMessage() else {
                completed(true)
                return
            }
            
            switch target {
            case "email":    self.emailField.printErrorMessage(message: message)
            case "password": self.passwordField.printErrorMessage(message: message)
            default: ()
            }
            completed(false)
        }
    }
    
    func handleErrorMessage(of textFieldType: String, about errorMessage: String?) {
        let textFieldType = TextFieldType.init(rawValue: textFieldType)
        
        guard let message = errorMessage else {
            switch textFieldType {
            case .email:            emailField.removeErrorMessage()
            case .password:         passwordField.removeErrorMessage()
            case .confirmPassword:  confirmPasswordField.removeErrorMessage()
            case .nickname:         nicknameField.removeErrorMessage()
            case .none: ()
            }
            return
        }
        
        switch textFieldType{
        case .email:            emailField.printErrorMessage(message: message)
        case .password:         passwordField.printErrorMessage(message: message)
        case .confirmPassword:  confirmPasswordField.printErrorMessage(message: message)
        case .nickname:         nicknameField.printErrorMessage(message: message)
        case .none: ()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGoalView" {
            let nextView = segue.destination as! RootTabBarController
            nextView.selectedIndex = 0
        }
    }
}
