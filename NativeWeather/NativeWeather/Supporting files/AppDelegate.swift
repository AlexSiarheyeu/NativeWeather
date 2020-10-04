//
//  AppDelegate.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/29/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
               
        let view = UIApplication.shared.windows.first!.rootViewController as! MainWeatherViewController
        let service = NetworkService()
        let presenter = MainWeatherPresenter(view: view, networkService: service)
        view.presenter = presenter
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        return true
    }
}



