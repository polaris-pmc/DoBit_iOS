//
//  UserRepository.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/14.
//

import Foundation

class UserRepository: NSObject {
    
    private let httpClient = HttpClient()

    func login(params: [String: String], completed: @escaping (Any) -> Void) {
        
        guard let email = params["email"],
              let password = params["password"] else { return }

        let path = "/users/login"
        httpClient.postResponse(path: path, params: params) { (result: Result<Response<UserResponse>, Error>) in
            
            if let response = try? result.get() {
                guard !response.isSuccess else {
                    print("success: \(response.result!)")
                    if let userResponse = response.result {
                        
                        UserDefaults.standard.set(userResponse.jwt, forKey: "jwt")
                        UserDefaults.standard.set(userResponse.nickname, forKey: "nickname")

                        let user = User(email: email, password: password, userInfo: userResponse)
                        completed(user)
                    }
                    return
                }
                
                switch LoginError(rawValue: response.code) {
                case .isNotExistingEmail:
                    completed(("email", response.message))
                case .isNotValidEmail:
                    completed(("email", response.message))
                case .isWrongPassword:
                    completed(("password", response.message))
                case .none:
                    print("unknown error", response.message)
                }
            }
        }
    }

    func signup(params: [String: String], completed: @escaping (Any) -> Void) {
        
        guard let email = params["email"],
              let password = params["password"] else { return }
        
        let path = "/users/signup"
        httpClient.postResponse(path: path, params: params) { (result: Result<Response<UserResponse>, Error>) in
            
            if let response = try? result.get() {
                guard !response.isSuccess else {
                    print("success: \(response.result!)")
                    if let userResponse = response.result {
                        let user = User(email: email, password: password, userInfo: userResponse)
                        completed(user)
                    }
                    return
                }
                
                switch SignUpError(rawValue: response.code) {
                case .isExistingEmail:
                    completed(("email", response.message))
                case .isNotValidEmail:
                    completed(("email", response.message))
                case .isNotValidPassword:
                    completed(("password", response.message))
                case .none:
                    print("unknown error", response.message)
                }
            }
        }
    }
}
