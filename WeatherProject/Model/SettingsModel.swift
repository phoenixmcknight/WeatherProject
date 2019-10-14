//
//  SettingsModel.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/12/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation

struct Settings:Codable {
    var windSpeed:Bool
    var temperature:Bool
    var precipitation:Bool
    //set up in settings VC then switch on variables
}
