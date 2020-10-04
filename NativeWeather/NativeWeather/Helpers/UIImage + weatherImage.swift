//
//  UIImage + weatherImage.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension UIImage {

    class func weatherIcon(of name: WeatherDefiner) -> UIImage? {
        
        switch name {
        case .thunderstorm:
            return UIImage(systemName: name.icon)
        case .drizzle:
            return UIImage(systemName: name.icon)
        case .rain:
            return UIImage(systemName: name.icon)
        case .snow:
            return UIImage(systemName: name.icon)
        case .clear:
            return UIImage(systemName: name.icon)
        case .clouds:
            return UIImage(systemName: name.icon)
        case .sunset:
            return UIImage(systemName: name.icon)
        case .sunrise:
            return UIImage(systemName: name.icon)
        }
    }
}

enum WeatherDefiner: String {
    
       case thunderstorm = "Thunderstorm"
       case drizzle = "Drizzle"
       case rain = "Rain"
       case snow = "Snow"
       case clear = "Clear"
       case clouds = "Clouds"
       case sunset
       case sunrise
       
       var icon: String {
        
           switch self {
               
           case .thunderstorm:
               return "wind"
           case .drizzle:
               return "cloud.drizzle.fill"
           case .rain:
               return "cloud.rain.fill"
           case .snow:
               return "cloud.snow.fill"
           case .clear:
               return "cloud.sun.fill"
           case .clouds:
               return "cloud.fill"
           case .sunset:
               return "sunset.fill"
           case .sunrise:
               return "sunrise.fill"
        }
       }
   }
