//
//  WeatherAPIModel.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
// MARK: - WeatherModel
struct WeatherModel: Codable {
    let timezone: String
    let daily: Daily
}



enum Icon: String, Codable {
    case cloudy = "cloudy"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
}

// MARK: - Daily
struct Daily: Codable {
    let summary: String
    let icon: Icon
    let data: [DailyDatum]
}

// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Int
    let summary, icon: String
    let sunriseTime, sunsetTime: Int
    let precipIntensity:Double
    let precipProbability: Double
    let precipType: Icon?
    let temperatureHigh: Double
    let temperatureLow: Double
    let windSpeed: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
}

