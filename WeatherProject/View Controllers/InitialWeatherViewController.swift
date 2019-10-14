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
     var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var settings:Settings!
   
    var weatherData = [DailyDatum]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    var textString:String = "" {
        didSet {
          
            loadData()
        }
    }
    var cityName = "" {
        didSet {
            cityLabel.text = self.cityName
        }
    }
    
    lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    lazy var promptLabel:UILabel = {
        let label = UILabel()
         label.backgroundColor = .red
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
   lazy var weatherCollectionView:UICollectionView = {
    let colletionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout )
    
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 150, height: 150)
    layout.minimumInteritemSpacing = 625
    colletionView.backgroundColor = .white
    colletionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weather")
    colletionView.dataSource = self
        colletionView.delegate = self
        return colletionView
    }()
    
   lazy var weatherTextField:UITextField = {
        let textfield = UITextField()
        textfield.delegate = self
    textfield.placeholder = "Enter ZipCode Or City Name"
    textfield.textColor = .black
    
        return textfield
    
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
 
        addSubViews()
        createCityLabelConstraints()
        createCollectionViewOutletConstraints()
        createTextFieldConstraints()
        createPromptLabelConstraints()
        checkUserDefaults()
        
    }
    func addSubViews() {
        view.addSubview(cityLabel)
        view.addSubview(weatherCollectionView)
        view.addSubview(weatherTextField)
        view.addSubview(promptLabel)
    }
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
              weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
      
    }

    func createTextFieldConstraints() {
       
        weatherTextField.textColor = .red
        weatherTextField.translatesAutoresizingMaskIntoConstraints = false
        weatherTextField.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: 20).isActive = true
        weatherTextField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        weatherTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weatherTextField.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        weatherTextField.becomeFirstResponder()
        
    }
    func createPromptLabelConstraints() {
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        promptLabel.topAnchor.constraint(equalTo: weatherTextField.bottomAnchor, constant: 5).isActive = true
        //promptLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        var xAnchor = promptLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor,constant: 200)
        xAnchor.isActive = true
        promptLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:-100).isActive = true
               
               promptLabel.text = "Enter a ZipCode or City Name"
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            xAnchor.isActive = false
            xAnchor = self.promptLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
            xAnchor.isActive = true
            UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseIn,animations: {
                self.view.layoutIfNeeded()
            })
       
    }
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
    func checkUserDefaults() {
        
    }
}
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
                      

                  case .failure(let error_):
                     UserDefaultsWrapper.shared.store(zipCodeString: "")
                    self.alert(error: error_)
                  }
              }
    }
    func alert(error:Error) {
        let alert =  UIAlertController(title: "Error", message: "Invalid ZipCode :\(error)", preferredStyle: .alert)
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
        cell.highTempLabel.text = weather.returnHighTemperatureInF(temp: weather.temperatureHigh)
        cell.lowTempLabel.text = weather.returnLowTemperatureInF(temp: weather.temperatureLow)
       
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
        detailVC.cityName = cityName
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}
