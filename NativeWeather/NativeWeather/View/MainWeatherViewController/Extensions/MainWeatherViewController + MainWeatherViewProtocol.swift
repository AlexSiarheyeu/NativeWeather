//
//  MainWeatherViewController + MainWeatherViewProtocol.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/3/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

enum Settings: String {
    case location = "App-prefs:Privacy&path=LOCATION"
    case general = "App-prefs:Privacy&path=GENERAL"
}

extension MainWeatherViewController: MainWeatherViewProtocol {
   
    func success() {
        collectionView.reloadData()
        collectionView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    func failure(error: Error) {
        
        let alert = UIAlertController(title: "Something went wrong",
                                          message: nil,
                                          preferredStyle: .alert)

            let action = UIAlertAction(title: "Go to settings",
                                       style: .default) { _ in
            UIApplication.shared.open(URL(string: Settings.general.rawValue)!)
            }
            
            let actionDismiss = UIAlertAction(title: "Cancel", style: .default) { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            }

            alert.addAction(action)
            alert.addAction(actionDismiss)
            present(alert, animated: true, completion: nil)
        }

    
    func failureLocation(error: Error) {
        
        let alert = UIAlertController(title: "Can't get region info",
                                             message: "Please enable GPS in the Settigs.",
                                             preferredStyle: .alert)

           let action = UIAlertAction(title: "Settings",
                                      style: .default) { _ in
           UIApplication.shared.open(URL(string: Settings.location.rawValue)!)
        }

           alert.addAction(action)
           present(alert, animated: true, completion: nil)
}
}
