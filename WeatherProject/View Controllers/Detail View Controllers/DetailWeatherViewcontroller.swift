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
    
  lazy  var locationLabel:UILabel = {
        let location = UILabel()
        return location
    }()
    
  lazy  var cityImage:UIImageView = {
        let city = UIImageView()
        return city
    }()
    
   lazy var acitivityIndicator:UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        return activity
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
