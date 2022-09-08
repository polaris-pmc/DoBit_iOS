//
//  Constants.swift
//  DoBit
//
//  Created by 김우성 on 2022/09/08.
//

import Foundation

// TODO: Info.plist - Scheme 맞춰서 구성할 것
enum NetworkURL {
    case test
    case product
    
    var urlString: String {
        switch (self) {
        case .test:
            return "https://lilyhome.shop/"
        case .product:
            return "https://sideproject.shop"
        }
    }
}

