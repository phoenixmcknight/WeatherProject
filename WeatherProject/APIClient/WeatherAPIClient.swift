//
//  WeatherAPIClient.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class WeatherApiClient {
    
    static let shared = WeatherApiClient()
    
    func getWeather(latLong:String, completionHandler:@escaping(Result<[DailyDatum],AppError>) -> Void) {
        let url = "https://api.darksky.net/forecast/0a592c9ebcf436a0d169213c2e2f899c/\(latLong)"
       
        guard let urlString = URL(string:url) else {
           completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: urlString, andMethod: .get) {
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    completionHandler(.failure(error))
                case.success(let data):
                    do { let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                        completionHandler(.success(weatherData.daily.data))
                    } catch{
        completionHandler(.failure(.invalidJSONResponse))
                    }
                }
            }
        }
    }
    
}
