//
//  User.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/05.
//

import Foundation

struct User {
    var email: String?
    var password: String?
    var userInfo: UserResponse?
    
    init(email: String, password: String, userInfo: UserResponse) {
        self.email = email
        self.password = password
        self.userInfo = userInfo
    }
}

struct UserResponse: Decodable {
    var userIdx: Int
    var jwt: String
    var nickname: String?
}

extension User {
    static let EMPTY = User(email: "", password: "", userInfo: UserResponse(userIdx: 0, jwt: ""))
}
