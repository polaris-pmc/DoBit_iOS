//
//  HabitViewModel.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/22.
//

import Foundation

class HabitViewModel: NSObject {
    @IBOutlet weak var repository: HabitRepository!
    
//    private var habitList: [Habit] = []
    
    private var habits: [Habit] = []
    
    func habitCount() -> Int {
        return habits.count
    }
    
    func habit(at indexPath: Int) -> Habit {
        return habits[indexPath]
    }
    
    func list(completed: @escaping () -> Void) {
        repository.list { result in
            self.habits = result ?? []
            completed()
        }
    }
    
    func toggleView(isDohabit: Bool, habitIndex: Int) {
        
        let params = [(isDohabit ? "doHabitIdx" : "dontHabitIdx") : habitIndex]
        repository.check(isDoHabit: isDohabit, params: params) { result in
//            debugPrint(result)
        }
    }
}
