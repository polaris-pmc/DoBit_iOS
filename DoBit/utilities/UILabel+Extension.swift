//
//  UILabel+Extension.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/19.
//

import UIKit

extension UILabel {
    func toggleTextColor() {
        if self.textColor == UIColor.appColor(.DarkGrey) {
            self.textColor = .appColor(.DoBitBlack)
        } else {
            self.textColor = .appColor(.DarkGrey)
        }
    }
}
