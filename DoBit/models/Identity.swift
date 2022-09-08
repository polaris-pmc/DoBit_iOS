//
//  Identity.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/17.
//

import UIKit

struct Identity {
    var identityInfo: Any
    var selected: Bool?
    var color: UIColor = .appColor(.DoBitBlack)
    
    init(identityInfo: Any, selected: Bool? = false) {
        self.identityInfo = identityInfo
        self.selected = selected
    }
    
    init(identityInfo: UserIdentityResponse) {
        self.identityInfo = identityInfo
        
        if let colorString = identityInfo.userIdentityColorName,
           let colorEnum = Colors(rawValue: colorString) {
            let color = UIColor.appColor(colorEnum)
            self.color = color
        }
    }
}

struct IdentityResponse: Decodable {
    var identityIdx: Int
    var identityName: String
}

struct UserIdentityResponse: Decodable {
    var userIdentityIdx: Int
    var userIdentityName: String
    var userIdentityColorName: String?
    
    var doHabitIdx: Int?
    var doHabitName: String?
    var dontHabitIdx: Int?
    var dontHabitName: String?
    
    init(userIdentityIdx: Int, userIdentityName: String, userIdentityColorName: String?, doHabitIdx: Int?, doHabitName: String?, dontHabitIdx: Int?, dontHabitName: String?) {
        self.userIdentityIdx = userIdentityIdx
        self.userIdentityName = userIdentityName
        self.userIdentityColorName = userIdentityColorName
        
        self.doHabitIdx = doHabitIdx
        self.doHabitName = doHabitName
        self.dontHabitIdx = dontHabitIdx
        self.dontHabitName = dontHabitName
    }
    
    init(userInfo: IdentityResponse) {
        self.userIdentityIdx = userInfo.identityIdx
        self.userIdentityName = userInfo.identityName
    }
}
