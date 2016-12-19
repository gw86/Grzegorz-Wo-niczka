//
//  DataManager.swift
//  Swift III
//
//  Created by Grzegorz Woźniczka on 05/12/2016.
//  Copyright © 2016 Grzegorz Woźniczka. All rights reserved.
//

import Foundation


enum DataManagerError: Error {
    
    case Unknown
    case FailedRequest
    case InvalidResponse
}

final class DataManager {
    
    typealias LoginsDataCompletion = (AnyObject?, DataManagerError?) -> ()
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func loginData(completion: @escaping LoginsDataCompletion) {
        
        let URL = baseURL
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.processLoginData(data: data!, completion: completion)            }.resume()
    }
    

    
    private func processLoginData(data: Data, completion: LoginsDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            completion(JSON, nil)
            
        } else {
            completion(nil, .InvalidResponse)
        }
    }
    
    
    
}





