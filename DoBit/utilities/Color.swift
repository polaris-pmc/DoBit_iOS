//
//  Color.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/05.
//

import UIKit

enum Colors: String {
    case LightGrey = "LightGrey"
    case DarkGrey = "DarkGrey"
    case DoBitGrey = "DoBitGrey"
    case DoBitBeige = "DoBitBeige"
    case DoBitBlack = "DoBitBlack"
    case DoBitBlue = "DoBitBlue"
    case DoBitGreen = "DoBitGreen"
    case DoBitPink = "DoBitPink"
    case DoBitPurple = "DoBitPurple"
    case DoBitRed = "DoBitRed"
    case DoBitSkyblue = "DoBitSkyblue"
    case DoBitYellow = "DoBitYellow"
}

extension UIColor {
    static func appColor(_ name: Colors) -> UIColor {
        switch name {
        case .LightGrey: return UIColor.init(named: "LightGrey")!
        case .DarkGrey: return UIColor.init(named: "DarkGrey")!
        case .DoBitGrey: return UIColor.init(named: "DoBitGrey")!
        case .DoBitBlack: return UIColor.init(named: "DoBitBlack")!
        case .DoBitBeige: return UIColor.init(named: "DoBitBeige")!
        case .DoBitPink: return UIColor.init(named: "DoBitPink")!
        case .DoBitRed: return UIColor.init(named: "DoBitRed")!
        case .DoBitYellow: return UIColor.init(named: "DoBitYellow")!
        case .DoBitGreen: return UIColor.init(named: "DoBitGreen")!
        case .DoBitSkyblue: return UIColor.init(named: "DoBitSkyblue")!
        case .DoBitBlue: return UIColor.init(named: "DoBitBlue")!
        case .DoBitPurple: return UIColor.init(named: "DoBitPurple")!
        }
    }
}
