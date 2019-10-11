//
//  DetailWeatherViewcontroller.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class DetailWeatherViewContrller:UIViewController {
    
    var passingWeather:WeatherModel!
    var passingDailyData:DailyDatum!
    
  lazy  var locationLabel:UILabel = {
    let location = UILabel(center: .center, color: .black)
    
        return location
    }()
    
  lazy  var cityImage:UIImageView = {
        let city = UIImageView()
    city.contentMode = .scaleAspectFit
    
        return city
    }()
    
    lazy var placeholderActivity:UIImageView = {
        
        let image = UIImageView()
        return image
        
    }()
    
    lazy var summaryLabel:UILabel = {
        let summary = UILabel(center: .center, color: .black)
        return summary
    }()
    
    lazy var highTempLabel:UILabel = {
              let high = UILabel(center: .center, color: .black)
       return high
          }()
       
    lazy  var lowTempLabel:UILabel = {
              let low = UILabel(center: .center, color: .black)
       return low
          }()
    
    lazy var sunRiseLabel:UILabel = {
        let sunrise = UILabel(center: .center, color: .black)

        return sunrise
    }()
    
    lazy var sunSetLabel:UILabel = {
      let sunset = UILabel(center: .center, color: .black)
        return sunset
    }()
    
    lazy var windSpeedLabel:UILabel = {
           let wind = UILabel(center: .center, color: .black)
        return wind
       }()
    
    lazy var inchsOfPercipLabel:UILabel = {
           let percip = UILabel(center: .center, color: .black)
           return percip
       }()
    
    lazy var stackViewDetails:UIStackView = {
        
        return returnStackViewDetails()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationLabelConstraints()
        setUpImageViewConstraints()
        setUpSummaryLabel()
        setUpStackViewDetails()
        addSubViews()
    }
    func addSubViews() {
        view.addSubview(locationLabel)
        view.addSubview(cityImage)
        view.addSubview(summaryLabel)
        view.addSubview(stackViewDetails)
    }
    
    func returnStackViewDetails() -> UIStackView {
        let stacky = UIStackView(arrangedSubviews: [highTempLabel,lowTempLabel,sunRiseLabel,sunSetLabel,windSpeedLabel,inchsOfPercipLabel])
                   
                   stacky.axis = .vertical
                   stacky.distribution = .fillEqually
                   stacky.alignment = .fill
                   stacky.spacing = 5
                   stacky.translatesAutoresizingMaskIntoConstraints = false
             return stacky
    }
    
    func setUpLocationLabelConstraints() {
        locationLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
         locationLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    func setUpImageViewConstraints() {
        cityImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        cityImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
               
                cityImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpSummaryLabel() {
        summaryLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 5).isActive = true
        
        summaryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
                    
                     summaryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    func setUpStackViewDetails() {
        stackViewDetails.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10).isActive = true
        stackViewDetails.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        stackViewDetails.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
         stackViewDetails.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpSubViewsWithInformation() {
        let location = passingWeather.addWordsToTimeZone()
        let rawDate = passingDailyData.time
        let formattedDate = passingDailyData.getDateFromTime(time: rawDate)
        let highTemp = passingDailyData.returnHighTemperatureInF(temp: passingDailyData.temperatureHigh)
        let lowTemp = passingDailyData.returnHighTemperatureInF(temp: passingDailyData.temperatureLow)
      
        
        locationLabel.text = "\(location) \(formattedDate)"
        summaryLabel.text = passingDailyData.summary
        highTempLabel.text = highTemp
        lowTempLabel.text = lowTemp
        
        
    }
    
}
    extension UILabel {
        public convenience init(center:NSTextAlignment,color:UIColor){
            self.init()
            self.textAlignment = center
            self.textColor = color
            
            
        }
    }

