//
//  MainWeatherPresenter + LocationDelegate.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import CoreLocation

extension MainWeatherPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
         guard let location = locations.first else { return }

         let currentLocation = CLLocation(latitude: location.coordinate.latitude,
                                   longitude: location.coordinate.longitude)
         
         fetchCoordinatesAndCity(from: currentLocation) { [weak self] (lat, lon, city) in
            guard let latitude = lat, let longitude = lon, let city = city else {return}
            self?.cityName = city
            self?.getWeather(latitude: latitude, longitude: longitude)
         }
         self.locationManager.stopUpdatingLocation()
         
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        switch CLLocationManager.authorizationStatus() {

        case .notDetermined, .restricted, .denied :
           self.view?.failureLocation(error: error)
        case .authorizedAlways, .authorizedWhenInUse :
            manager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
        
    }
     
    private func fetchCoordinatesAndCity(from location: CLLocation, completion: @escaping (_ lat: Double?, _ lon: Double?, _ city: String?) -> ()) {
         
         CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
             completion(location.coordinate.latitude,
                        location.coordinate.longitude,
                        placemarks?.first?.locality)
            
            if let error = error {
                self.view?.failureLocation(error: error)
            }
         }
     }
     
    func startLocationManager() {
         
         if CLLocationManager.locationServicesEnabled() {
             locationManager.delegate = self
             locationManager.desiredAccuracy = kCLLocationAccuracyBest
             locationManager.distanceFilter = kCLDistanceFilterNone
             locationManager.startMonitoringSignificantLocationChanges()
             locationManager.requestWhenInUseAuthorization()
             locationManager.startUpdatingLocation()
         }
     }
}
