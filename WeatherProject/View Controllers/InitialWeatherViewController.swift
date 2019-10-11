//
//  InitialWeatherViewController.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class InitialWeatherViewController:UIViewController {
    
    var weatherData = [DailyDatum]()
    var textString:String = "" {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
   lazy var weatherCollectionView:UICollectionView = {
     let colletionView = UICollectionView()
    colletionView.backgroundColor = .white
    colletionView.register(InitialWeatherViewController.self, forCellWithReuseIdentifier: "weather")
    colletionView.dataSource = self
        colletionView.delegate = self
        return colletionView
    }()
    
   lazy var weatherTextField:UITextField = {
        let textfield = UITextField()
        textfield.delegate = self
        return textfield
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createCityLabelConstraints() {
        view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func createCollectionViewOutletConstraints() {
        view.addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
              weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        weatherCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }


private func loadData() {
    WeatherApiClient.shared.getWeather(latLong:textString) {
        (results) in
        switch results {
        case .failure(let error):
            print(error)
            
        case .success(let data):
            self.weatherData = data
        
        }
    }
    
}
}
extension InitialWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textString = textField.text ?? ""
        loadData()
        return true
    }
}
extension InitialWeatherViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weather = weatherData[indexPath.row]
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as! WeatherCollectionViewCell
        
        cell.dateLabel.text = weather.getDateFromTime(time: weather.time)
        cell.highTempLabel.text = weather.returnHighTemperatureInF(temp: weather.temperatureHigh)
        cell.lowTempLabel.text = weather.returnLowTemperatureInF(temp: weather.temperatureLow)
       
        cell.weatherImage.image = weather.returnPictureBasedOnIcon(icon: weather.icon)
        
        return cell
    }
    
    
}
