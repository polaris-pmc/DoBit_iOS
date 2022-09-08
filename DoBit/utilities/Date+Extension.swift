//
//  Date+Extension.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/25.
//

import Foundation

extension Date {
    
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
}

class DateUtil {
    static let shared = DateUtil()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter
    }()
    
    func formatDateStringWithDot(date: Date) -> String {
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    func formatDateWithDash(year: Int, month: Int, day: Int) -> Date {
        let month = String(format: "%02d", month)
        let day = String(format: "%02d", day)
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: "\(year)-\(month)-\(day)")!
    }
}
