//
//  IdentityViewModel.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/19.O
//

import Foundation

class IdentityViewModel: NSObject {
    @IBOutlet weak var repository: IdentityRepository!
    
    private var identityList = [Identity]()
    
    func identityCount() -> Int {
        return identityList.count
    }

    func identity(at index: Int) -> Identity {
        return identityList[index]
    }
    
    func identityIdx(of index: Int) -> Int {
        return (identityList[index].identityInfo as! UserIdentityResponse).userIdentityIdx
    }
    
    func findIdentity(of identityIndex: Int) -> Identity? {
        let idx = identityList.firstIndex { identity in
            identityIndex == (identity.identityInfo as! UserIdentityResponse).userIdentityIdx
        }!
        return identityList[idx]
    }
    
    func deleteIdentity(at index: Int) {
        identityList.remove(at: index)
    }
    
    func toggleSelected(indexOf index: Int) {
        identityList[index].selected = !identityList[index].selected!
    }
    
    
    
    // MARK: - Networking Identity(Goal)
    func list(isExample: Bool = false, completed: @escaping (Bool) -> Void ) {
//        print(UserDefaults.standard.string(forKey: "jwt") ?? "no jwt")
        repository.list(isExample: isExample) { identities in
            self.identityList = identities ?? []
            completed(true)
        }
    }
    
    func makeIdentity(name identiyName: String, completed: @escaping () -> Void) {
        let params: [String : Any] = ["identityName": identiyName, "userIdentityColorIdx": 9]

        repository.create(myIdentity: params) { identity in
            self.identityList.append(identity)
            completed()
        }
    }
    
    func sendIdentity(_ identityIdxs: [Int], completed: @escaping (Bool) -> Void) {
        let params = ["identityList": identityIdxs]
        print(params)
        
        repository.add(identities: params) { result in
            guard result else {
                completed(false)
                return
            }
            completed(true)
        }
    }
}
