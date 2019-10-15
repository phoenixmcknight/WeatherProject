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
    //MARK: Instances of Structs
   
    var settings:Settings!
    
    var weatherData = [DailyDatum]() {
        didSet {
            
            self.weatherCollectionView.reloadData()
        }
        
    }
    //MARK: Miscellaneous Variables
     var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var textString:String = "" {
        didSet {
            loadData()
        }
    }
    var cityName = "" {
        didSet {
            cityLabel.text = "Weather forecast for \(self.cityName)"
        }
    }
    
    //MARK: Outlet Variables
    
    lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    lazy var promptLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.alpha = 0.0
        return label
    }()
    
    lazy var settingsButton:UIBarButtonItem = {
        let button = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: #selector(settingsButtonAction))
        button.image = UIImage(named: "gearbox")
        return button
    }()
    
    
    lazy var weatherCollectionView:UICollectionView = {
        let colletionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout )
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumInteritemSpacing = 625
        colletionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weather")
        colletionView.dataSource = self
        colletionView.delegate = self
        return colletionView
    }()
    
    lazy var weatherTextField:UITextField = {
        let textfield = UITextField()
        textfield.delegate = self
        textfield.placeholder = "Your Text Goes Here"
        textfield.textColor = .black
        textfield.contentHorizontalAlignment = .center
        return textfield
        
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkUserDefaults()
        weatherTextField.becomeFirstResponder()
        settingsPersistenceHelper()
        UIView.animate(withDuration: 0.0, delay: 0.8, options: [.curveEaseIn], animations: {
            
        }) { (_) in
            UIView.animate(withDuration: 3.5, delay: 0.0, options: [.curveEaseOut], animations: {
                self.view.backgroundColor = #colorLiteral(red: 0.3, green: 0.3, blue: 0.8, alpha: 1.0)
                self.weatherCollectionView.backgroundColor = #colorLiteral(red: 0.3, green: 0.3, blue: 0.8, alpha: 1.0)
               
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        createCityLabelConstraints()
        createCollectionViewOutletConstraints()
        createTextFieldConstraints()
        createPromptLabelConstraints()
        
    }
    //MARK: Functions - Button Actions
    
    @objc func settingsButtonAction() {
        let settingsVC = SettingsVC()
        // settingsVC.modalPresentationStyle = .currentContext
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    
   
    //MARK: Functions - Constraints
    
    func createCityLabelConstraints() {
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 150).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func createCollectionViewOutletConstraints() {
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
        weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: -500).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func createTextFieldConstraints() {
        
        weatherTextField.textColor = .black
        weatherTextField.translatesAutoresizingMaskIntoConstraints = false
        weatherTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 20).isActive = true
        weatherTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        weatherTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weatherTextField.widthAnchor.constraint(equalToConstant: 175).isActive = true
        
        weatherTextField.becomeFirstResponder()
    }
    func createPromptLabelConstraints() {
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.topAnchor.constraint(equalTo: weatherTextField.bottomAnchor, constant: 5).isActive = true
        
        var xAnchor = promptLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor,constant: 200)
        xAnchor.isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:-100).isActive = true
        
        promptLabel.text = "Enter a ZIP Code or City"
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            xAnchor.isActive = false
            xAnchor = self.promptLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
            xAnchor.isActive = true
            UIView.animate(withDuration: 5, delay: 0.8, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseIn,animations: {
                self.view.layoutIfNeeded()
                self.promptLabel.alpha = 1.0
            })
        }
    }
    //MARK: Functions - Miscellaneous
    
    func addSubViews() {
           self.navigationItem.rightBarButtonItem = settingsButton
           view.addSubview(cityLabel)
           view.addSubview(weatherCollectionView)
           view.addSubview(weatherTextField)
           view.addSubview(promptLabel)
       }
    
    func checkUserDefaults() {
        if UserDefaultsWrapper.shared.getZipCode() != nil {
            
            textString = UserDefaultsWrapper.shared.getZipCode()!
            
            if textString != "" {
                zipCodeHelper()
            }
            weatherTextField.text = UserDefaultsWrapper.shared.getZipCode()
        }
    }
    func settingsPersistenceHelper() {
        if let savedSettings = try? SettingsPersistenceHelper.shared.getSettings() {
            settings = savedSettings
        } else {
            let defaultSettings = Settings(windSpeed: true, temperature: true, precipitation: true)
            settings = defaultSettings
        }
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

//MARK: Extensions

extension InitialWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            textString = text
            
        }
        zipCodeHelper()
        
        return true
    }
    func zipCodeHelper() {
        ZipCodeHelper.getLatLong(fromZipCode: textString) {
            (results) in
            switch results {
                
            case .success(let lat, let long, let name):
                UserDefaultsWrapper.shared.store(zipCodeString: self.textString)
                self.textString = "\(lat),\(long)"
                self.cityName = name
            
            case .failure( _):
                UserDefaultsWrapper.shared.store(zipCodeString: "")
                self.alert()
            }
        }
    }
    func alert() {
        let alert =  UIAlertController(title: "Error", message: "Invalid ZIP Code or City", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){ (actions) in self.weatherTextField.text = ""
        }
        alert.addAction(cancel)
        self.present(alert,animated: true)
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
        cell.highTempLabel.text = weather.returnHighTemperature(temp: weather.temperatureHigh, usingImperialMeasurement: settings.temperature)
        cell.lowTempLabel.text = weather.returnLowTemperature(temp: weather.temperatureLow, usingInternationalMeasurements: settings.temperature)
        
        cell.weatherImage.image = weather.returnPictureBasedOnIcon(icon: weather.icon)
        cell.changeColorOfBorderCellFunction = {
            CustomLayer.shared.createCustomlayer(layer: cell.layer)
        }
        cell.changeColorOfBorderCellFunction()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailWeatherViewContrller()
        detailVC.passingDailyData = weatherData[indexPath.row]
        detailVC.detailVCSettings = settings
        detailVC.cityName = cityName
        self.navigationController?.pushViewController(detailVC, animated: false)
        UIView.transition(from: self.view, to: detailVC.view, duration: 3.5, options: [.transitionCurlUp],completion: nil)
    }
}
