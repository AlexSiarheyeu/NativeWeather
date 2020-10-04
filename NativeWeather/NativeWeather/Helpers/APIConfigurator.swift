//
//  APIConfigurator.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/1/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import Foundation

class API {
    
    static let key = "&appid=8047c07650b47e354af6d4a18a1010fe"
    static let oneCallURL = "https://api.openweathermap.org/data/2.5/onecall?"
    
    enum DataSettings: String {
        case celsius = "&units=metric"
        case languageEN = "&lang=en"
    }
    
    class func assembleURLWith(latitude: Double, longitude: Double) -> String {
        
        let configureURL = API.oneCallURL + "lat=\(latitude)&lon=\(longitude)" +
                           API.DataSettings.languageEN.rawValue +
                           API.DataSettings.celsius.rawValue + API.key
        return configureURL
    }
}
