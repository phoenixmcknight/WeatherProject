//
//  WeatherAPIModel.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit
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
 //MARK:Functions
    func getDateFromTime(time:Int) -> String {
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        let testDate = dateFormatter.string(from: date as Date)
        
        return testDate.components(separatedBy: " at")[0]
    }
    
    func getSpecificTimeFromTime(time:Int) -> String {
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        let testDate = dateFormatter.string(from: date as Date)
        
        return testDate.components(separatedBy: " at")[1]
    }
    
    
    func returnHighTemperature(temp:Double, usingImperialMeasurement:Bool) -> String {
        
        switch usingImperialMeasurement {
        case false :
            return "High: \(((temp - 32) * 5/9).rounds(toPlaces: 2))°C"
            
        case true :
            
            return "High: \(temp)°F"
        }
    }
    func returnLowTemperature(temp:Double,usingInternationalMeasurements:Bool) -> String {
        
        switch usingInternationalMeasurements {
            
        case true:
            return "Low: \(temp)°F"
        case false:
            return "Low: \(((temp - 32) * 5/9).rounds(toPlaces: 2))°C"
        }
    }
    
    func returnPrecipitationMeasurement(inches:Double,usingImperialMeasurement:Bool) -> String {
        switch usingImperialMeasurement {
        case false:
            return "Meters Of Precipitation: \((inches * 2.54).rounds(toPlaces: 2))"
        case true:
            return "Inches Of Precipitation: \(inches.rounded())"
            
        }
    }
    
    func returnWindSpeed(MPH:Double,usingImperialMeasurement:Bool) -> String {
        switch usingImperialMeasurement {
        case false :
            return "Windspeed: \((MPH * 1.609).rounds(toPlaces: 2)) KM/H"
        case true :
            return "Windspeed: \(MPH) MPH"
        }
    }
    
    func returnPictureBasedOnIcon(icon:String) -> UIImage {
        switch icon {
        case "rain":
            return UIImage(named: "rain")!
        case "cloudy":
            return UIImage(named: "cloudy")!
            
        case "partly-cloudy-night":
            return UIImage(named: "pcloudyn")!
        case "clear-day":
            return UIImage(named: "clear")!
            
        case "clear-night":
            return UIImage(named:"clearn")!
        case "partly-cloudy-day":
            return UIImage(named:"pcloudy" )!
        case "snow":
            return UIImage(named: "snow")!
        case "sleet":
            return UIImage(named: "sleet")!
        case "wind":
            return UIImage(named: "wind")!
        case "fog":
            return UIImage(named:"fog")!
        default:
            return UIImage(named: "image")!
        }
    }
    func currentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func getWeatherDataTest() {
        
    }
}


