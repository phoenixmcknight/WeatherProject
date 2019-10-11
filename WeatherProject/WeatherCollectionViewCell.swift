//
//  WeatherCollectionViewCell.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/10/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    var dateLabel:UILabel = {
        let date = UILabel()
        return date
    }()
    
    var highTempLabel:UILabel = {
           let high = UILabel()
           return high
       }()
    
    var lowTempLabel:UILabel = {
           let low = UILabel()
           return low
       }()
    
    var weatherImage:UIImageView = {
        let weather = UIImageView()
        return weather
    }()
    override init(frame: CGRect) {
          super.init(frame:frame)
          
      }
      required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
    
    func setUpWeatherImageConstraints() {
        
    }
}
