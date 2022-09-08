//
//  CalendarRepository.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/22.
//

import Foundation

class CalendarRepository: NSObject {
    private let httpClient = HttpClient()
    
    func list(params: (year: Int, month: Int), completed: @escaping ([Graph]?) -> Void) {
        let path = "/tracker?year=\(params.year)&month=\(params.month)"
        
        httpClient.getResponse(path: path) { (response: Response<[Graph]>) in
            if response.isSuccess {
                print("success: \(response.result!)")
                if let graphInfos = response.result {
                    completed(graphInfos)
                }
            }
        }
    }
}
