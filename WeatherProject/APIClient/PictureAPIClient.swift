//
//  ApiClient.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class PictureAPIClient {
    static let shared = PictureAPIClient()
    
    func getPictures(searchTerm:String,completionHandler:@escaping (Result<[Hit],AppError>) -> Void) {
        
        
        
        
        let urlString = "https://pixabay.com/api/?q=\(searchTerm.replacingOccurrences(of: " ", with: "_"))&key=\(SecretKeys.pixaBayKey.lowercased())"
        
        guard let url  = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let URLisWorking):
                do { let decoded = try JSONDecoder().decode(Picture.self, from: URLisWorking)
                    
                    completionHandler(.success(decoded.hits))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
        
}
}
