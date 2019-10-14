//
//  UserDefaultsWrapper.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/12/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation



struct UserDefaultsWrapper {
    static let shared = UserDefaultsWrapper()
    
    private let zipCode = "zipcode"
    
    private let settingsMenu = "settings"
    
    func store(zipCodeString:String) {
        UserDefaults.standard.set(zipCodeString, forKey: zipCode)
    }
    func getZipCode() -> String? {
        UserDefaults.standard.value(forKey: zipCode) as? String
    }
    func store(settings:Settings) {
        UserDefaults.standard.set(settings, forKey: settingsMenu)
    }
    func getSettingsMenu() -> Settings? {
        UserDefaults.standard.value(forKey: settingsMenu) as? Settings
    }
}
