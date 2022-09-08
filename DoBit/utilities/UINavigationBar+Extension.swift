//
//  UINavigationBar+Extension.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/24.
//

import UIKit

// NavigationBar 투명하게
extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.layer.borderColor = UIColor.appColor(.DoBitBlack).cgColor
    }
}

extension UINavigationItem {
    
    static let backItem: UIBarButtonItem = {
        let backItem = UIBarButtonItem()
        backItem.title = ""
//        backItem.image = UIImage(named: "arrow.left") // FIX: image 변경 안됨
        backItem.tintColor = .appColor(.DoBitBlack)
        return backItem
    }()
}
