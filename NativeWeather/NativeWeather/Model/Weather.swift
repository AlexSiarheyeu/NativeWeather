//
//  File.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/1/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import Foundation

class Weather: Decodable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Decodable {
    
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Double
    let weather: [WeatherState]
}

struct WeatherState: Decodable {
    
    let main: String
    let description: String
}

struct Hourly: Decodable {
    
    let dt: Int
    let temp: Double
    let weather: [WeatherState]
}

struct Daily: Decodable {
    
    let dt: Int
    let temp: Temperature
    let weather: [WeatherState]
    
    struct Temperature: Decodable {
        let min: Double
        let max: Double
    }
}
