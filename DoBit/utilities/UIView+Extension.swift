//
//  UIView+Extension.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

import UIKit

extension UIView {
    func setCornerRoundedEmpty() {
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.appColor(.DoBitBlack).cgColor
    }
    
    func toggleViewColor(with color: UIColor = .clear) {
        if self.backgroundColor == .clear {
            self.setCornerRoundedFilled(with: color)
        } else {
            self.setCornerRoundedEmpty()
        }
    }
    
    func setCornerRoundedFilled(with color: UIColor) {
        self.backgroundColor = color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func toggleBackgroundColor() {
        if self.backgroundColor == .appColor(.DarkGrey) {
            self.backgroundColor = .appColor(.DoBitBlack)
        } else {
            self.backgroundColor = .appColor(.DarkGrey)
        }
    }
    
    func setSelectedBorder() {
//        let borderWidth: CGFloat = 3.0
        self.frame.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.appColor(.DoBitBlack).cgColor
    }
}

