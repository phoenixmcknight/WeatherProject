//
//  SettingsVC.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/13/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC:UIViewController {
    
    var settings:Settings!
    var promptLabel:UILabel = {
        let frame = UIScreen.main.bounds
        let label = UILabel(frame: CGRect(x: frame.minX - 10, y: frame.maxY * 0.1, width: frame.width , height: frame.height * 0.05))
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Settings Menu"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    var tempSegmentedController:UISegmentedControl = {
        let items = ["Temperature in Farenheit","Temperature in Celcius"]
        let frame = UIScreen.main.bounds
        let segment = UISegmentedControl(items: items)
       
        segment.frame = CGRect(x: frame.minX + 10, y: frame.maxY * 0.2, width: frame.width - 10, height: frame.maxY * 0.1)
        segment.addTarget(self, action: #selector(changeTemperatureMeasurement(sender:)), for: .valueChanged)
        segment.backgroundColor = .white
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
     var windSpeedSegmentedController:UISegmentedControl = {
           let items = ["Wind Speed in MPH","Wind Speed in KM/H"]
           let frame = UIScreen.main.bounds
           let segment = UISegmentedControl(items: items)
          
           segment.frame = CGRect(x: frame.minX + 10, y: frame.maxY * 0.4, width: frame.width - 10, height: frame.maxY * 0.1)
          segment.addTarget(self, action: #selector(changeWindSpeedMeasurement(sender:)), for: .valueChanged)
        segment.backgroundColor = .white
           segment.selectedSegmentIndex = 0
           
           return segment
       }()
    
    var precipitationSegmentedController:UISegmentedControl = {
              let items = ["Precipitation in Inches","Precipitation in Meters"]
              let frame = UIScreen.main.bounds
              let segment = UISegmentedControl(items: items)
             
              segment.frame = CGRect(x: frame.minX + 10, y: frame.maxY * 0.6, width: frame.width - 10, height: frame.maxY * 0.1)
        segment.addTarget(self, action: #selector(changePrecipitationMeasurement(sender:)), for: .valueChanged)
        segment.backgroundColor = .white
              segment.selectedSegmentIndex = 0
              
              return segment
          }()
    
    
    @objc func changeTemperatureMeasurement(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings.temperature = true
            try? SettingsPersistenceHelper.shared.save(newSetting: settings)
        case 1:
            settings.temperature = false
            try? SettingsPersistenceHelper.shared.save(newSetting: settings)

        default:
            print("error")
        }
    }
    @objc func changeWindSpeedMeasurement(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings.windSpeed = true
            try? SettingsPersistenceHelper.shared.save(newSetting: settings)

        case 1:
            settings.windSpeed = false
            try? SettingsPersistenceHelper.shared.save(newSetting: settings)
            
        default:
            print("error")
        }
    }
    @objc func changePrecipitationMeasurement(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings.precipitation = true
            try? SettingsPersistenceHelper.shared.save(newSetting: settings)
        case 1:
            settings.precipitation = false
            try? SettingsPersistenceHelper.shared.save(newSetting: settings)
        default:
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkPersistenceHelper()
        addSubViews()
        setUpSegmentIndexes()
    }
    func checkPersistenceHelper() {
        if let savedSettings = try? SettingsPersistenceHelper.shared.getSettings() {
            settings = savedSettings
        } else {
            let defaultSettings = Settings(windSpeed: true, temperature: true, precipitation: true)
            settings = defaultSettings
        }
        
        
    }
    func setUpSegmentIndexes() {
        if settings.windSpeed { windSpeedSegmentedController.selectedSegmentIndex = 0 } else { windSpeedSegmentedController.selectedSegmentIndex = 1 }
        
        if settings.temperature {
            tempSegmentedController.selectedSegmentIndex = 0 } else {
            tempSegmentedController.selectedSegmentIndex = 1
        }
        if settings.precipitation {
                  precipitationSegmentedController.selectedSegmentIndex = 0 } else {
                  precipitationSegmentedController.selectedSegmentIndex = 1
              }
    }
    func addSubViews() {
        self.view.addSubview(tempSegmentedController)
        self.view.addSubview(windSpeedSegmentedController)
        self.view.addSubview(precipitationSegmentedController)
        self.view.addSubview(promptLabel)


    }
}

