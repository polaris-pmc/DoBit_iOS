//
//  Response.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/15.
//

import Foundation

struct SimpleResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct Response<T: Decodable>: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: T?
    
    enum CodingKeys: CodingKey {
        case isSuccess, code, message, result
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try values.decode(Bool.self, forKey: .isSuccess)
        code = try values.decode(Int.self, forKey: .code)
        message = try values.decode(String.self, forKey: .message)
        
        result = (try? values.decode(T.self, forKey: .result)) ?? nil
    }
}

