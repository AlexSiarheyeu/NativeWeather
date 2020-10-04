//
//  NetworkService.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/1/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getWeatherAt(latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>)  -> ())
}

class NetworkService: NetworkServiceProtocol {
    
    func getWeatherAt(latitude: Double, longitude: Double, completion: @escaping (Result<Weather, Error>)  -> ()) {

        self.locationURLRequestAt(latitude: latitude, longitude: longitude) { (data, error) in
          
           if let error = error {
               completion(.failure(error))
               return
           }
            
           guard let weather = self.genericJSONDecoder(type: Weather.self, data: data) else {return}
           completion(.success(weather))
        }
    }
    
    private func genericJSONDecoder<T: Decodable>(type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        
        guard let data = data else  { return nil }
        
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let error {
            print("Failed to decode JSON", error.localizedDescription)
            return nil
        }
    }
    
    private func locationURLRequestAt(latitude: Double, longitude: Double, completion: @escaping (Data?, Error?) -> ()) {
        
        guard let url = URL(string: API.assembleURLWith(latitude: latitude, longitude: longitude)) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, error)
          
        }.resume()
    }

    
}
