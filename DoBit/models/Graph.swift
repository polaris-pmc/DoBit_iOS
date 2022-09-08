//
//  Graph.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/22.
//

import UIKit

struct Graph: Decodable {
    var userIdentityIdx: Int
    var userIdentityName: String
    var userIdentityColorName: String
    var userIdentityColor: UIColor = .appColor(.DoBitBlack)
    
    var checkDateList: [Int]
    var graphDataList: [Float]
    
    enum CodingKeys: CodingKey {
        case userIdentityIdx, userIdentityName, userIdentityColorName, checkDateList, graphDataList
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdentityIdx = try values.decode(Int.self, forKey: .userIdentityIdx)
        userIdentityName = try values.decode(String.self, forKey: .userIdentityName)
        userIdentityColorName = try values.decode(String.self, forKey: .userIdentityColorName)
        
        if let colorEnum = Colors(rawValue: userIdentityColorName) {
            let color = UIColor.appColor(colorEnum)
            userIdentityColor = color
        }
        
        checkDateList = try values.decode([Int].self, forKey: .checkDateList)
        graphDataList = try values.decode([Float].self, forKey: .graphDataList)
    }
}
