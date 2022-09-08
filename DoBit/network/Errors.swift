//
//  Errors.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/13.
//

import Foundation

enum SignUpError: Int, Error {
    case isNotValidEmail = 2021
    case isExistingEmail = 2036
    case isNotValidPassword = 2035
}

extension SignUpError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .isNotValidEmail:
            return "이메일 형식이 올바르지 않습니다."
        case .isExistingEmail:
            return "존재하는 이메일입니다."
        case .isNotValidPassword:
            return "유효하지 않은 패스워드입니다. 최소 8자리면서 숫자, 문자, 특수문자 각각 1개 이상 포함하십시오."
        }
    }
}

enum LoginError: Int, Error {
    case isNotValidEmail = 2021
    case isNotExistingEmail = 2073
    case isWrongPassword = 2074
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .isNotValidEmail:
            return "이메일 형식을 확인해주세요."
        case .isNotExistingEmail:
            return "이메일 주소를 확인해주세요."
        case .isWrongPassword:
            return "비밀번호를 확인해주세요."
        }
    }
}
