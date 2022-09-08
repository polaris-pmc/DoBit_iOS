//
//  UserViewModel.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/05.
//

import Foundation

class UserViewModel: NSObject {
    @IBOutlet weak var repository: UserRepository!
    
    private var user = User.EMPTY
    var errorTuple = (target: "", message: "")
    
//    public init(user: User) {
//        self.user = user
//    }
    
    public var email: String {
        return user.email!
    }
    
    public var nickname: String {
        return user.userInfo!.nickname!
    }
    
    func getErrorMessage() -> (String, String)? {
        guard errorTuple != ("", "") else {
            return nil
        }
        
        let temp = errorTuple
        self.errorTuple = ("", "")
        
        return temp
    }
    
    // MARK:- repository에 Network 요청
    func login(email: String, password: String, completed: @escaping () -> Void) {
        let params: [String: String] = ["email": email, "password": password]
        
        repository.login(params: params) { result in
            guard let user = result as? User else {
                self.errorTuple = result as! (target: String, message: String)
                completed()
                return
            }
            self.user = user
            completed()
       }
    }
    
    func signup(email: String, password: String, confirmPassword: String, nickname: String, completed: @escaping () -> Void) {
        let params: [String: String] = ["email": email, "password": password, "confirmPassword": confirmPassword, "nickname": nickname]

        repository.signup(params: params) { result in
            guard let user = result as? User else {
                self.errorTuple = result as! (target: String, message: String)
                completed()
                return
            }
            self.user = user
            self.user.userInfo?.nickname = nickname
            // TODO: enable
            UserDefaults.standard.set(nickname, forKey: "nickname")
            UserDefaults.standard.set(self.user.userInfo?.jwt, forKey: "jwt")
            completed()
        }
    }
}
