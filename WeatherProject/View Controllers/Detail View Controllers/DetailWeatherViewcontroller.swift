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
    var cityName:String! {
        didSet {
            loadData()
    }
    }
    var passingDailyData:DailyDatum!
   
    var pictureData = [Hit]() {
        didSet {
            setUpSubViewsWithInformation()
        }
    }
    
  lazy  var locationLabel:UILabel = {
    let location = UILabel(center: .center, color: .black)
    
        return location
    }()
    
  lazy  var cityImage:UIImageView = {
        let city = UIImageView()
    city.contentMode = .scaleAspectFill
    
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
    
    lazy var barButton:UIBarButtonItem = {
        let bar = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButton))
        bar.isEnabled = false
        return bar
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setUpLocationLabelConstraints()
        setUpImageViewConstraints()
        setUpSummaryLabel()
        setUpStackViewDetails()
        
    }
    func addSubViews() {
        self.navigationItem.rightBarButtonItem = barButton
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
                   stacky.spacing = 10
                   stacky.translatesAutoresizingMaskIntoConstraints = false
             return stacky
    }
    
    func setUpLocationLabelConstraints() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
         locationLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    func setUpImageViewConstraints() {
        cityImage.translatesAutoresizingMaskIntoConstraints = false

        cityImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        cityImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
               
                cityImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        summaryLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 5).isActive = true
        
        summaryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
                    
                     summaryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    func setUpStackViewDetails() {
        stackViewDetails.translatesAutoresizingMaskIntoConstraints = false

        stackViewDetails.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10).isActive = true
        stackViewDetails.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        stackViewDetails.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
         stackViewDetails.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setUpSubViewsWithInformation() {
        let rawDate = passingDailyData.time
        let formattedDate = passingDailyData.getDateFromTime(time: rawDate)
        let highTemp = passingDailyData.returnHighTemperatureInF(temp: passingDailyData.temperatureHigh)
        let lowTemp = passingDailyData.returnLowTemperatureInF(temp: passingDailyData.temperatureLow)
        let sunrise = passingDailyData.getSpecificTimeFromTime(time: passingDailyData.sunriseTime)
        let sunset = passingDailyData.getSpecificTimeFromTime(time:passingDailyData.sunsetTime)
              
        locationLabel.text = "\(cityName!) : \(formattedDate)"
        summaryLabel.text = passingDailyData.summary
        highTempLabel.text = highTemp
        lowTempLabel.text = lowTemp
        sunRiseLabel.text = sunrise
        sunSetLabel.text =  sunset
        windSpeedLabel.text = "Windspeed: \(passingDailyData.windSpeed)"
        inchsOfPercipLabel.text = "Inches Of Precipitation: \(passingDailyData.precipIntensity.rounded())"
        
        if let image = pictureData.randomElement()?.largeImageURL {
        ImageHelper.shared.getImage(urlStr: image) { (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                    //image picker here
                case .success(let image):
                    self.cityImage.image = image
                    self.barButton.isEnabled = true
                
                }
            }
            }
        } else {
            cityImage.image = UIImage(named: "imageLoadError-1")
            cityImage.contentMode = .scaleAspectFit
            barButton.isEnabled = true
            

        }
    }
    
    @objc func saveButton() {

        let newPhoto = FavoriteImages(image: (cityImage.image?.pngData())!, date: currentDate())
        
        try? ImagePersistenceHelper.manager.save(newImage: newPhoto)
        saveAlert()
        
    }
    func saveAlert() {
        let alert = UIAlertController(title: "Saved", message: "Click on the favorites tag to see your saved images", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert,animated: true)
    }
    private func loadData() {
        PictureAPIClient.shared.getPictures(searchTerm:cityName!) {
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.pictureData = data
                    
                }
            }
        }
    }
    
    private func currentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
}
    extension UILabel {
        public convenience init(center:NSTextAlignment,color:UIColor){
            self.init()
            self.textAlignment = center
            self.textColor = color
            
            
        }
    }

