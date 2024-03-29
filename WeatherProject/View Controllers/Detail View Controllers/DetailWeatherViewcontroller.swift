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
    
    //MARK: Variables - Instances of Structs
    var detailVCSettings:Settings!
    
    var passingDailyData:DailyDatum!
    
    var pictureData = [Hit]() {
        didSet {
            setImage()
        }
    }
    
    //MARK: Variables - Label Outlets
    
    lazy  var locationLabel:UILabel = {
        let location = UILabel(center: .center, color: .black)
        location.font = location.font.withSize(16)
               location.font = UIFont.boldSystemFont(ofSize: 16)
        return location
    }()
    lazy  var cityImage:UIImageView = {
        let city = UIImageView()
        city.contentMode = .scaleAspectFit
        city.isHidden = true
        return city
    }()
    
    lazy var placeHolderImage:UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "clearn")
    
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
         let stacky = UIStackView(arrangedSubviews: [highTempLabel,lowTempLabel,sunRiseLabel,sunSetLabel,windSpeedLabel,inchsOfPercipLabel])
         
         stacky.axis = .vertical
         stacky.distribution = .fillEqually
         stacky.alignment = .fill
         stacky.spacing = 10
         stacky.translatesAutoresizingMaskIntoConstraints = false
         return stacky
     }()
     
     lazy var saveBarButton:UIBarButtonItem = {
         let bar = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButton))
         bar.isEnabled = false
         return bar
     }()
    
    var cityName:String! {
        didSet {
            loadData()
        }
    }
    
    
    
    
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        addSubViews()
        setUpLocationLabelConstraints()
        setUpImageViewConstraints()
        setUpPlaceHolder()
        setUpSummaryLabel()
        setUpStackViewDetails()
        setUpSubViewsWithInformation()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        placeHolderAnimation()
     
    }
   
    
    //MARK: Functions
 private func addSubViews() {
        self.navigationItem.rightBarButtonItem = saveBarButton
        view.addSubview(locationLabel)
        view.addSubview(cityImage)
        view.addSubview(placeHolderImage)
        view.addSubview(summaryLabel)
        view.addSubview(stackViewDetails)
    }
    
    
//MARK: Functions - Constraints
 private   func setUpPlaceHolder() {
        placeHolderImage.translatesAutoresizingMaskIntoConstraints = false
        
        placeHolderImage.centerYAnchor.constraint(equalTo: cityImage.centerYAnchor).isActive = true
        placeHolderImage.centerXAnchor.constraint(equalTo: cityImage.centerXAnchor).isActive = true
        placeHolderImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        placeHolderImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
       
        
    }
 private   func setUpLocationLabelConstraints() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        locationLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
 private   func setUpImageViewConstraints() {
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        
        cityImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        cityImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        cityImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
  private  func setUpSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        summaryLabel.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 5).isActive = true
        
        summaryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        summaryLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
 private   func setUpStackViewDetails() {
        stackViewDetails.translatesAutoresizingMaskIntoConstraints = false
            stackViewDetails.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    
        stackViewDetails.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10).isActive = true
        stackViewDetails.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
      var leadingAnchor =   stackViewDetails.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:  -600)
    leadingAnchor.isActive = true
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              leadingAnchor.isActive = false
        UIView.animate(withDuration: 3, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseIn,animations: {
                  
                self.view.layoutIfNeeded()
                leadingAnchor = self.stackViewDetails.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
                leadingAnchor.isActive = true
                  self.stackViewDetails.alpha = 1.0
        

              }, completion: nil)
    }
    }
    
//MARK: Functions - Change Outlets
    
  private  func setImage() {
        if let image = pictureData.randomElement()?.largeImageURL {
            ImageHelper.shared.getImage(urlStr: image) { (results) in
                DispatchQueue.main.async {
                    switch results {
                    case .failure(let error):
                        print(error)

                    case .success(let image):
                        self.cityImage.image = image
                        self.cityImage.isHidden = false
                        self.placeHolderImage.isHidden = true
                        self.saveBarButton.isEnabled = true
                    }
                }
            }
        } else {
            cityImage.image = UIImage(named: "imageLoadError-1")
            cityImage.contentMode = .scaleAspectFit
            saveBarButton.isEnabled = true
            self.cityImage.isHidden = false
            self.placeHolderImage.isHidden = true
        }
    }
 private   func setUpSubViewsWithInformation() {
        let rawDate = passingDailyData.time
        let formattedDate = passingDailyData.getDateFromTime(time: rawDate)
        let sunrise = passingDailyData.getSpecificTimeFromTime(time: passingDailyData.sunriseTime)
        let sunset = passingDailyData.getSpecificTimeFromTime(time:passingDailyData.sunsetTime)
        
        locationLabel.text = "Weather forecast for \(cityName!) : \(formattedDate)"
        
        summaryLabel.text = passingDailyData.summary
        
        highTempLabel.text = passingDailyData.returnHighTemperature(temp: passingDailyData.temperatureHigh, usingImperialMeasurement: detailVCSettings.temperature)
        
        lowTempLabel.text = passingDailyData.returnLowTemperature(temp: passingDailyData.temperatureLow, usingInternationalMeasurements: detailVCSettings.temperature)
        
        sunRiseLabel.text = "Sunrise: \(sunrise) "
        
        sunSetLabel.text =  "Sunset: \(sunset)"
        
        windSpeedLabel.text = passingDailyData.returnWindSpeed(MPH: passingDailyData.windSpeed, usingImperialMeasurement: detailVCSettings.windSpeed)
        
        inchsOfPercipLabel.text = passingDailyData.returnPrecipitationMeasurement(inches: passingDailyData.precipIntensity, usingImperialMeasurement: detailVCSettings.precipitation)
    }
    
//MARK: Button Functions
    
    @objc func saveButton() {
        
        let newPhoto = FavoriteImages(image: (cityImage.image?.pngData())!, date: passingDailyData.currentDate())
        
        try? ImagePersistenceHelper.manager.save(newImage: newPhoto)
        saveAlert()
    }
    
//MARK: Miscellaneous functions
    
    
   private func saveAlert() {
        let alert = UIAlertController(title: "Saved", message: "Click on the 'favorites' tag to see your saved images", preferredStyle: .alert)
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
//MARK: Functions - Animations
 
    private  func placeHolderAnimation() {

        UIView.transition(with: self.placeHolderImage, duration: 2.5, options: [.transitionCrossDissolve], animations: {
            
            self.placeHolderImage.image = UIImage(named: "clear")
       }, completion: nil)
                  
          }
}
//MARK: Extensions

extension UILabel {
    public convenience init(center:NSTextAlignment,color:UIColor){
        self.init()
        self.textAlignment = center
        self.textColor = color
    }
}

