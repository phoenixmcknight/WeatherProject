//
//  testAPIClient.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/11/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class NewWeatherApiClient {
    
    static let shared = NewWeatherApiClient()
    
    func getWeather( completionHandler:@escaping(Result<WeatherModel,AppError>) -> Void) {
        let url = "https://api.darksky.net/forecast/0a592c9ebcf436a0d169213c2e2f899c/42.3601,-71.0589,255657"
       
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
                        completionHandler(.success(weatherData))
                    } catch{
        completionHandler(.failure(.invalidJSONResponse))
                    }
                }
            }
        }
    }
    
}

