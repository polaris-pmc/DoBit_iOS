//
//  IdentityRepository.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/19.
//

import Foundation

class IdentityRepository: NSObject {
    
    private let httpClient = HttpClient()
    
    func list(isExample: Bool = false, userIdentityIdx: Int? = nil, completed: @escaping ([Identity]?) -> Void) {
        let path = "/identity"
        
        if isExample {
            httpClient.getResponse(path: path + "/example") { (response: Response<[IdentityResponse]>) in
                guard response.isSuccess,
                      let identities = response.result else {
                    return
                }
                
                completed(identities.map { Identity(identityInfo: $0) })
            }
        } else {
            httpClient.getResponse(path: path) { (response: Response<[UserIdentityResponse]>) in
                guard response.isSuccess,
                      let identities = response.result else {
                    return
                }
                completed(identities.map { Identity(identityInfo: $0) })
            }
        }
    }
    
    func detail(of userIdentityIdx: Int, completed: @escaping (Identity) -> Void) {
        let path = "/identity/\(userIdentityIdx)"
        
        httpClient.getResponse(path: path) { (response: Response<UserIdentityResponse>) in
            guard response.isSuccess,
                  let identity = response.result else {
                return
            }
            completed(Identity(identityInfo: identity))
        }
    }
    
    func detail(of habitIdx: Int, isDo: Bool, completed: @escaping (Any) -> Void) {
        
        if isDo {
            let path = "/dohabit/\(habitIdx)"
            
            httpClient.getResponse(path: path) { (response: Response<DoHabit>) in
                guard response.isSuccess,
                      let doHabit = response.result else {
                    print(response.message)
                    return
                }
                completed(doHabit)
            }
        } else {
            let path = "/donthabit/\(habitIdx)"
            
            httpClient.getResponse(path: path) { (response: Response<DontHabit>) in
                guard response.isSuccess,
                      let dontHabit = response.result else {
                    print(response.message)
                    return
                }
                completed(dontHabit)
            }
        }
    }
    
    func create(myIdentity params: [String: Any], completed: @escaping (Identity) -> Void) {
        let path = "/direct-identity"
        
        httpClient.postResponse(path: path, params: params) { (result: Result<Response<IdentityResponse>, Error>) in
            
            if let response = try? result.get() {
                guard response.isSuccess else {
                    print("unknown error", response.message)
                    return
                }
                print("success: \(response.result!)")
                if response.result != nil {
                    if let identityResponse = response.result {
                        let newIdentity = Identity(identityInfo: identityResponse, selected: true)
                        completed(newIdentity)
                    }
                }
            }
        }
    }
    
    func create(identity params: [String: Any], completed: @escaping (Identity) -> Void) {
        let path = "/identity/plus"
        
        httpClient.postResponse(path: path, params: params) { (result: Result<Response<IdentityResponse>, Error>) in
            
            if let response = try? result.get() {
                guard response.isSuccess else {
                    print("unknown error", response.message)
                    return
                }
                print("success: \(response.result!)")
                if let identityResponse = response.result {
                    let newIdentity = Identity(identityInfo: UserIdentityResponse(userInfo: identityResponse), selected: true)
                    completed(newIdentity)
                }
            }
        }
    }
    
    func add(identities params: [String: [Int]], completed: @escaping (Bool) -> Void) {
        let path = "/identity"
        
        httpClient.postResponse(path: path, params: params) { (result: Result<SimpleResponse, Error>) in
            if let response = try? result.get() {
                completed(response.isSuccess)
            }
            completed(false)
        }
    }
    
    func makeHabit(at userIdentityIdx: Int, isDo: Bool, habit parmas: [String: Any], completed: @escaping (Bool) -> Void) {
        let path = "/identity/\(userIdentityIdx)/\(isDo ? "dohabit" : "donthabit")"
        
        httpClient.postResponse(path: path, params: parmas) { (result: Result<SimpleResponse, Error>) in
            if let response = try? result.get() {
                completed(response.isSuccess)
            }
            completed(false)
        }
    }
    
    func delete(at userIdentityIdx: Int, completed: @escaping (Bool) -> Void) {
        let path = "/identity/\(userIdentityIdx)/status"
        
        httpClient.patchResponse(path: path, params: nil) { result in
            completed(result)
        }
    }
    
    func deleteHabit(at habitIdx: Int, isDo: Bool, completed: @escaping (Bool) -> Void) {
        let path = "/\(isDo ? "dohabit" : "donthabit")/\(habitIdx)/status"
        
        httpClient.patchResponse(path: path, params: nil) { result in
            completed(result)
        }
    }
    
    func update(at userIdentityIdx: Int, params: [String: Any], completed: @escaping (Bool) -> Void) {
        let path = "/identity/\(userIdentityIdx)"
        
        httpClient.patchResponse(path: path, params: params) { result in
            completed(result)
        }
    }
    
    func updateHabit(habitIdx: Int, isDo: Bool, params: [String: Any], completed: @escaping (Bool) -> Void) {
        
        let path = "/\(isDo ? "dohabit" : "donthabit")/\(habitIdx)"
        
        httpClient.patchResponse(path: path, params: params) { result in
            completed(result)
        }
    }
}
