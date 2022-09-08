//
//  HabitRepository.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/22.
//

import Foundation

class HabitRepository: NSObject {
    private let httpClient = HttpClient()

    func list(completed: @escaping ([Habit]?) -> Void) {
        let path = "/habit"
        
        httpClient.getResponse(path: path) { (response: Response<[Habit]>) in
            if response.isSuccess {
                print("success: \(response.result!)")
                if let habits = response.result {
                    let filtered = habits.filter { $0.doHabitIdx != nil || $0.dontHabitIdx != nil }
                    completed(filtered)
                }
            }
        }
    }
    
    func check(isDoHabit: Bool, params: [String: Int], completed: @escaping (Bool) -> Void) {
        let path = "/\(isDoHabit ? "dohabit" : "donthabit")/check"
        
        httpClient.postResponse(path: path, params: params) { (result: Result<SimpleResponse, Error>) in
            if let response = try? result.get() {
                completed(response.isSuccess)
            }
            completed(false)
        }
    }
}
