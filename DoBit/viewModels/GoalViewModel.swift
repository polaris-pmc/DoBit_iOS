//
//  GoalViewModel.swift
//  Pods
//
//  Created by 서민주 on 2021/07/26.
//

import Foundation

class GoalViewModel: NSObject {
    @IBOutlet weak var repository: IdentityRepository!
    
    private var identity: Identity?
    
    var doHabit: DoHabit?
    var dontHabit: DontHabit?
    
    func identity(of info: String) -> Any? {
        let identityInfo = identity!.identityInfo as! UserIdentityResponse
        
        switch info {
        case "idx": return identityInfo.userIdentityIdx
        case "name": return identityInfo.userIdentityName
        case "color": return identity?.color ?? .appColor(.DoBitBlack)
        case "doIdx": return identityInfo.doHabitIdx
        case "do": return identityInfo.doHabitName ?? ""
        case "dontIdx": return identityInfo.dontHabitIdx
        case "dont": return identityInfo.dontHabitName ?? ""
        default: return ()
        }
    }
    
    // MARK: - Networking Identity(Goal)
    func addIdentity(name identiyName: String, completed: @escaping (Int) -> Void) {
        let params: [String : Any] = ["identityName": identiyName, "userIdentityColorIdx": 9]

        repository.create(identity: params) { identity in
            let identityInfo = identity.identityInfo as! UserIdentityResponse
            completed(identityInfo.userIdentityIdx)
        }
    }
    
    func detailIdentity(idx: Int, completed: @escaping () -> Void ) {

        repository.detail(of: idx) { result in
            self.identity = result
            completed()
        }
    }
    
    func deleteIdentity(at idx: Int) {
        guard let identityIdx = (identity?.identityInfo as? UserIdentityResponse)?.userIdentityIdx else { return }
        
        repository.delete(at: identityIdx) { result in
            guard result else {
                print("identity delete failed")
                return
            }
            // 성공
        }
    }
    
    func updateIdentity(idx: Int, title: String, colorIdx: Int) {
        
        let params: [String: Any] = ["userIdentityName": title, "userIdentityColorIdx": colorIdx]
        repository.update(at: idx, params: params) { result in
            guard result else {
                print("identity update error")
                return
            }
//            self.detailIdentity(idx: identityIdx) {
//                
//            }
        }
    }
    
    // MARK: - Networking Habit(Goal)
    func makeHabit(identityIdx: Int, isDo: Bool, params: [String: Any], completed: @escaping () -> Void) {
        
        repository.makeHabit(at: identityIdx, isDo: isDo, habit: params) { result in
            guard result else {
                print("add habit failed")
                return
            }
            self.detailIdentity(idx: identityIdx) {
                completed()
            }
        }
    }
    
    func detailHabit(habitIdx: Int, isDo: Bool, completed: @escaping (Bool) -> Void) {

        repository.detail(of: habitIdx, isDo: isDo) { result in
            print(result)
            if isDo {
                self.doHabit = result as? DoHabit
                completed(true)
            } else {
                self.dontHabit = result as? DontHabit
                completed(true)
            }
        }
    }
    
    func deleteHabit(habitIdx: Int, isDo: Bool) {

        repository.deleteHabit(at: habitIdx, isDo: isDo) { result in
            guard result else {
                print("delete habit failed")
                return
            }
        }
    }
    
    func updateHabit(isDo: Bool, params: [String: Any]) {
        let habitIdx: Int = identity(of: "idx") as! Int
        
        repository.updateHabit(habitIdx: habitIdx, isDo: isDo, params: params) { result in
            guard result else {
                print("update habit failed")
                return
            }
        }
    }
}


