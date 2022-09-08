//
//  UIButton+Extension.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

import UIKit

extension UIButton {
    
    func setColor() {
        self.setTitleColor(UIColor.appColor(.DoBitBlack), for: .normal)
    }
    
    func setFont() {
        self.titleLabel?.font = UIFont.fontKorean()
        self.setTitleColor(UIColor.appColor(.DoBitBlack), for: .normal)
    }
    
    func selectedButton(color: UIColor = .appColor(.DoBitBlack)) {
        self.backgroundColor = self.isSelected ? color : .appColor(.DarkGrey)
    }
    
//    func setIconButton() {
//
//    }
//
//    func setTextButton() {
//
//    }
    
    func setFloatingButton() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appColor(.DoBitBlack).cgColor
    }
}
