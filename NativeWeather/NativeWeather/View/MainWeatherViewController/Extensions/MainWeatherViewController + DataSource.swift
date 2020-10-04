//
//  File.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/4/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit


extension MainWeatherViewController: UICollectionViewDataSource {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
                
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DailyWeatherCell
 
            cell.presenter = presenter
            cell.configure(row: indexPath.row)
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! WeatherStateCell
            cell.presenter = presenter
            cell.configure(row: indexPath.row)
           
            return cell
         }
        
       return UICollectionViewCell()
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 7
        case 1: return presenter.weatherStates.count
        default: return 0
        }
    }
}
