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
    //MARK: Variables - Instances of Structs / Classes
    var settings:Settings!
    
    //MARK:Variables - Outlets
    
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
    
    //MARK: Functions - Segmented Controller Actions
    
    @objc func changeTemperatureMeasurement(sender:UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            segmentAnimations()
            settings.temperature = true
            
        case 1:
            segmentAnimations()
            settings.temperature = false
            
        default:
            print("error")
        }
    }
    @objc func changeWindSpeedMeasurement(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings.windSpeed = true
            segmentAnimations()
            
            
        case 1:
            settings.windSpeed = false
            segmentAnimations()
            
            
        default:
            print("error")
        }
    }
    @objc func changePrecipitationMeasurement(sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settings.precipitation = true
            segmentAnimations()
            
        case 1:
            settings.precipitation = false
            segmentAnimations()
            
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        try? SettingsPersistenceHelper.shared.save(newSetting: settings)
    }
    
    //MARK: Functions - Miscellaneous
    
    func checkPersistenceHelper() {
        if let savedSettings = try? SettingsPersistenceHelper.shared.getSettings() {
            settings = savedSettings
        } else {
            let defaultSettings = Settings(windSpeed: true, temperature: true, precipitation: true)
            settings = defaultSettings
        }
    }
    func segmentAnimations() {
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseOut], animations: changeSegmentedIndex, completion: nil)
    }
    
    func changeSegmentedIndex() {
        let frame = UIScreen.main.bounds
        let first = CGRect(x: frame.minX + 10, y: frame.maxY * 0.2, width: frame.width - 10, height: frame.maxY * 0.1)
        let second = CGRect(x: frame.minX + 10, y: frame.maxY * 0.4, width: frame.width - 10, height: frame.maxY * 0.1)
        let third = CGRect(x: frame.minX + 10, y: frame.maxY * 0.6, width: frame.width - 10, height: frame.maxY * 0.1)
        
        let segmentArray = [tempSegmentedController,windSpeedSegmentedController,precipitationSegmentedController]
        
        for i in segmentArray {
            switch i.frame {
            case first:
                i.frame = third
            case second:
                i.frame = first
            case third:
                i.frame = second
            default:
                return
            }
        }
    }
    func addSubViews() {
        self.view.addSubview(tempSegmentedController)
        self.view.addSubview(windSpeedSegmentedController)
        self.view.addSubview(precipitationSegmentedController)
        self.view.addSubview(promptLabel)
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
}
