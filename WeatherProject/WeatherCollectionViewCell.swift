//
//  WeatherCollectionViewCell.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

protocol CellDelegate:AnyObject {
    func actionSheet(tag:Int)
}


class WeatherCollectionViewCell: UICollectionViewCell {
 lazy   var dateLabel:UILabel = {
        let date = UILabel()
    date.textAlignment = .center
    return date
    }()
    
  lazy  var highTempLabel:UILabel = {
           let high = UILabel()
    high.textAlignment = .center
    return high
       }()
    
 lazy   var lowTempLabel:UILabel = {
           let low = UILabel()
    low.textAlignment = .center
    return low
       }()
    
 lazy   var weatherImage:UIImageView = {
        let weather = UIImageView()
    weather.contentMode = .scaleAspectFit
    
        return weather
    }()
    
   lazy var temperatureStackView:UIStackView = {
        
        let stacky = UIStackView(arrangedSubviews: [highTempLabel,lowTempLabel])
                    
                    stacky.axis = .vertical
                    stacky.distribution = .fillEqually
                    stacky.alignment = .fill
                    stacky.spacing = 5
                    stacky.translatesAutoresizingMaskIntoConstraints = false
              return stacky
        
    }()
    
    lazy var weatherImageAndTemperatureStackView:UIStackView = {
         let stacky = UIStackView(arrangedSubviews: [weatherImage,temperatureStackView])
                     
                     stacky.axis = .vertical
                     stacky.distribution = .fillEqually
                     stacky.alignment = .fill
                     stacky.spacing = 10
                     stacky.translatesAutoresizingMaskIntoConstraints = false
               return stacky
    }()
    
    var changeColorOfBorderCellFunction: (()->()) = {}


    override init(frame: CGRect) {
          super.init(frame:frame)
        
        setUpDateLabelConstraints()
        setUpStackViewConstraints()
        
      }
     
    
   
    
    
    
    func setUpDateLabelConstraints() {
        self.contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
        
    }
    func setUpStackViewConstraints() {
        
        self.contentView.addSubview(weatherImageAndTemperatureStackView)
        weatherImageAndTemperatureStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        
        weatherImageAndTemperatureStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        weatherImageAndTemperatureStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        weatherImageAndTemperatureStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
}
