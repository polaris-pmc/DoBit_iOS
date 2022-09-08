//
//  SceneDelegate.swift
//  DoBit
//
//  Created by 서민주 on 2021/06/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        UserDefaults.standard.removeObject(forKey: "jwt")
        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let jwt = UserDefaults.standard.string(forKey: "jwt") {
            // TODO : login시 UserDefaults 추가
            print("jwt exist")
            autoLogin(key: jwt) { isLoggedIn in
                let rootVC = storyboard.instantiateViewController(identifier: isLoggedIn ? "MainTabBarController" : "AuthNavController")
                window.rootViewController = rootVC
            }
        } else {
            let authVC = storyboard.instantiateViewController(identifier: "AuthNavController")
            window.rootViewController = authVC

        }
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func autoLogin(key jwt: String, completed: @escaping (Bool) -> Void) {
            
        let baseUrl = "https://lilyhome.shop"
        let endPoint = "/users/auto-login"
        
        HttpClient()
            .postResponse(path: endPoint, params: [:]) { (result: Result<SimpleResponse, Error>) in
        
                if let response = try? result.get() {
                    guard response.isSuccess else {
                        completed(false)
                        return
                    }
                    print("success: auto login")
                    completed(true)
                }
            }
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
}

