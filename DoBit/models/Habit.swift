//
//  Habit.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/16.
//

struct Habit: Decodable {
    var identityIdx: Int
    var userIdentityColorName: String
    
    var doHabitIdx: Int?
    var doHabitName: String?
    var doHabitSummary: String?
    var isDoHabitCheck: String?
    
    var dontHabitIdx: Int?
    var dontHabitName: String?
    var dontHabitSummary: String?
    var isDontHabitCheck: String?
}

struct DoHabit: Decodable {
    var doName: String
    var doWhen: String
    var doWhere: String
    var doStart: String

    var doRoutine: [String]?
    var doEnv: [String]?
    var doNext: [String]?
    var doElse: [String]?
}

struct DontHabit: Decodable {
    var dontName: String
    var dontAdvantage: String
    var dontEnv: String

    var dontRoutine: [String]?
    var dontMotive: [String]?
    var dontElse: [String]?
}
