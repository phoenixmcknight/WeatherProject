//
//  File.swift
//  WeatherProject
//
//  Created by Phoenix McKnight on 10/14/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation

extension Double {
   func rounds(toPlaces places:Int) -> Double {
       let divisor = pow(10.0, Double(places))
       return (self * divisor).rounded() / divisor
   }
}
