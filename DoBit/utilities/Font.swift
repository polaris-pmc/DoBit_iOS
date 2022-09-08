//
//  Font.swift
//  DoBit
//
//  Created by 서민주 on 2021/06/29.
//

import UIKit

enum FontType { case regular, bold, medium, light, semibold }
enum FontHierarchy { case headline1, headline2, subtitle, body, description }

extension UIFont {
    
    static func fontKorean(type: FontType = .medium, size: FontHierarchy = .body) -> UIFont {
        var fontName = "SpoqaHanSansNeo-"
        var fontSize = CGFloat(14)
        
        switch type {
        case .regular: fontName += "Regular"
        case .light: fontName += "Light"
        case .medium: fontName += "Medium"
        case .semibold: fontName += "SemiBold"
        case .bold: fontName += "Bold"
        }
        
        switch size {
        case .headline1: fontSize = 30
        case .headline2: fontSize = 24
        case .subtitle: fontSize = 16
        case .body: fontSize = 14
        case .description: fontSize = 11
        }
        
        return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
