//
//  WeatherHeaderDataManager.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/1/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import CoreLocation


protocol MainWeatherViewProtocol: class {
     func success()
     func failureLocation(error: Error)
     func failure(error: Error)
}

protocol MainWeatherPresenterProtocol: class {
    
    init(view: MainWeatherViewProtocol, networkService: NetworkServiceProtocol)
    
    var weather: Weather? { get set }
    var cityName: String { get }
    var weatherDescription: String  { get }
    var temperature: String { get }
    var presentDay: String { get }
    var maxTemperature: String { get }
    var minTemperature: String { get }
    
    func hourlyDay(row: Int) -> String
    func hourlyTemperature(row: Int) -> String
    func hourlyWeatherStateImage(row: Int) -> UIImage
        
    func dailyDay(row: Int) -> String
    func dailyHighTemperature(row: Int) -> String
    func dailyLowTemperature(row: Int) -> String
    func dailyWeatherStateImage(row: Int) -> UIImage

    var weatherStates: [(String, String)] {get}
    
    func getWeather(latitude: Double, longitude: Double)
}

class MainWeatherPresenter: NSObject, MainWeatherPresenterProtocol {

    var weather: Weather?
    weak var view: MainWeatherViewProtocol?
    var networkService: NetworkServiceProtocol?
    
    var locationManager = CLLocationManager()
    
    required init(view: MainWeatherViewProtocol, networkService: NetworkServiceProtocol) {
        super.init()
        
        self.view = view
        self.networkService = networkService
        
        locationManager.requestAlwaysAuthorization()
        startLocationManager()
    }
    
    //MARK: Current forecast
    
    var cityName: String = ""
    
    var weatherDescription: String {
        guard let description = weather?.current.weather[0].description else { return "" }
        return description.capitalizingFirstLetter()
    }
    
    var temperature: String {
        guard let temp = weather?.current.temp else { return ""}
        return "\(String(format: "%.0f", temp))º"
    }
    
    var presentDay: String {
        guard let hour = weather?.current.dt else {return ""}
        return UnixDateConverter.convert(unixDate: hour, withFormat: .day)
    }
    
    var maxTemperature: String {
        guard let temp = weather?.daily[0].temp.max else { return ""}
        return "\(String(format: "%.0f", temp))"
    }
    
    var minTemperature: String {
        guard let temp = weather?.daily[0].temp.min else { return ""}
        return "\(String(format: "%.0f", temp))"
    }
    
    //MARK: Hourly forecast

    func hourlyTemperature(row: Int) -> String {
        
        guard let temp = weather?.hourly[row].temp,
              let sunset = weather?.current.sunset,
            let sunrise = weather?.current.sunrise else {return ""}
                
        let sunsetString = UnixDateConverter.convert(unixDate: sunset, withFormat: .hourAndMin)
        let sunriseString = UnixDateConverter.convert(unixDate: sunrise, withFormat: .hourAndMin)
        
        let hourlyWeather = hourlyDay(row: row)
        
        switch hourlyWeather {
            case sunsetString: return "Sunset"
            case sunriseString: return "Sunrise"
        default:
            return "\(String(format: "%.0f", temp))º"
        }
    }
    
    func hourlyDay(row: Int) -> String {
        
        guard let hour = weather?.hourly[row].dt,
              let sunset = weather?.current.sunset,
              let sunrise = weather?.current.sunrise else {return ""}

        
        let sunsetString = UnixDateConverter.convert(unixDate: sunset, withFormat: .hour)
        let sunriseString = UnixDateConverter.convert(unixDate: sunrise, withFormat: .hour)
        let hourString = UnixDateConverter.convert(unixDate: hour, withFormat: .hour)

        if hourString == sunsetString {
            return UnixDateConverter.convert(unixDate: sunset, withFormat: .hourAndMin)
        }
        
        if hourString == sunriseString {
            return UnixDateConverter.convert(unixDate: sunrise, withFormat: .hourAndMin)
        }
        
        //if row == 0 { return "Now" }
        
        return hourString
    }
    
    func hourlyWeatherStateImage(row: Int) -> UIImage {
        
        guard let weatherState = weather?.hourly[row].weather[0].main,
              let defineIcon = WeatherDefiner(rawValue: weatherState),
              let sunset = weather?.current.sunset,
              let sunrise = weather?.current.sunrise else { return UIImage() }

        let sunsetString = UnixDateConverter.convert(unixDate: sunset, withFormat: .hourAndMin)
        let sunriseString = UnixDateConverter.convert(unixDate: sunrise, withFormat: .hourAndMin)
        
        let hourlyWeather = hourlyDay(row: row)
        
        if hourlyWeather == sunsetString {
            return UIImage.weatherIcon(of: .sunset)!
        }
        
        if hourlyWeather == sunriseString {
            return UIImage.weatherIcon(of: .sunrise)!
        }
        
            return UIImage.weatherIcon(of: defineIcon)!
    }
    
    //MARK: Daily forecast
    
    func dailyDay(row: Int) -> String {
        guard let day = weather?.daily[row].dt else {return ""}
        return UnixDateConverter.convert(unixDate: day, withFormat: .day)
    }
    
    func dailyHighTemperature(row: Int) -> String {
        guard let temp = weather?.daily[row].temp.max else { return ""}
        return "\(String(format: "%.0f", temp))"
    }
    
    func dailyLowTemperature(row: Int) -> String {
        guard let temp = weather?.daily[row].temp.min else { return ""}
        return "\(String(format: "%.0f", temp))"
    }
    
    func dailyWeatherStateImage(row: Int) -> UIImage {
        guard let weatherState = weather?.daily[row].weather[0].main,
              let defineIcon = WeatherDefiner(rawValue: weatherState) else
              { return UIImage() }
        return UIImage.weatherIcon(of: defineIcon)!
    }
    
    //MARK: Weather states

    var weatherStates: [(String, String)] {
        
        guard let sunriseHour = weather?.current.sunrise else {return [("", "")]}
        let sunrise = UnixDateConverter.convert(unixDate: sunriseHour,
                                                     withFormat: .hourAndMin)
        
        guard let sunsetHour = weather?.current.sunset else {return [("", "")]}
        let sunset = UnixDateConverter.convert(unixDate: sunsetHour,
                                               withFormat: .hourAndMin)
        
        guard let humidity = weather?.current.humidity,
              let windSpeed = weather?.current.wind_speed,
              let pressure = weather?.current.pressure,
              let visibility =   weather?.current.visibility,
              let feelsLike = weather?.current.feels_like else {return [("", "")]}
        
        let feelsLike0f = "\(String(format: "%.0f", feelsLike))º"
        
        guard let weatherDescription = weather?.current.weather[0].description.capitalizingFirstLetter() else {return [("", "")] }
        guard let temp = weather?.daily[0].temp.max else { return [("", "")] }
        let maxTemp = "\(String(format: "%.0f", temp))"
        let description = "Today: \(weatherDescription) conditions with \(windSpeed) m/s winds. The high will be \(maxTemp)º"
        
        let dict = [(description, ""),
                    ("SUNRISE", sunrise),
                    ("SUNSET", sunset),
                    ("HUMIDITY", "\(humidity)%"),
                    ("WIND SPEED", "\(windSpeed) m/s"),
                    ("FEELS LIKE", feelsLike0f),
                    ("PRESSURE", "\(pressure) hPa"),
                    ("VISIBILITY" , "\(visibility) m")]
        
        return dict
    }
    
    func getWeather(latitude: Double, longitude: Double) {

        networkService?.getWeatherAt(latitude: latitude, longitude: longitude, completion: { [weak self] (result) in
            
            DispatchQueue.main.async {
             
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
              
            }
        })
    }
}
