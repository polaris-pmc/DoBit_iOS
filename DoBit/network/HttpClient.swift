//
//  HttpClient.swift
//  DoBit
//
//  Created by 서민주 on 2021/06/29.
//

import Foundation
import Alamofire

class HttpClient {
    private let baseUrl: String = NetworkURL.product.urlString
    let defaultHeaders: HTTPHeaders = ["Content-Type": "application/json", "X-ACCESS-TOKEN": UserDefaults.standard.string(forKey: "jwt") ?? "no_value"]
    
//    init(baseUrl: String) {
//        self.baseUrl = baseUrl
//    }
    
    func getResponse<T: Decodable>(path: String, variable: String? = nil,  completed: @escaping (Response<T>) -> Void) {
        
        let url = URL(string: baseUrl + path)!
        
        AF.request(url, headers: defaultHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Response<T>.self){ response in
                
                dump(response.result)
                switch response.result {
                case .success(let objects):
                    completed(objects)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
    }
    
    func postResponse<T: Decodable>(path: String, params: [String: Any], completed: @escaping (Result<T, Error>) -> Void) {
        
        let url = URL(string: baseUrl + path)!
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: defaultHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self){ response in
                
//                debugPrint(response.result)
                switch response.result {
                case .success(let object):
                    completed(.success(object))
                case .failure(let error):
                    completed(.failure(error))
                }
            }
    }
    
    func patchResponse(path: String, params: [String: Any]?, completed: @escaping (Bool) -> Void) {
        
        let url = URL(string: baseUrl + path)!
        
        AF.request(url, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: defaultHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SimpleResponse.self){ response in
                
//                debugPrint(response.result)
                switch response.result {
                case .success(let object):
                    completed(object.isSuccess)
                case .failure(_):
                    completed(false)
                }
            }
    }
}
