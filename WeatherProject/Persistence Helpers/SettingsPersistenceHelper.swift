//
//  SettingsPersistenceHelper.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/13/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
struct SettingsPersistenceHelper {

    static let shared = SettingsPersistenceHelper()
    
    func save(newSetting: Settings) throws {
       try persistenceHelper.save2(newElement: newSetting)
   }
    
    
    func getSettings() throws -> [Settings]? {
        return try persistenceHelper.getObjects()
    }

   
     private let persistenceHelper = PersistenceHelper<Settings>(fileName: "settings.plist")
}
