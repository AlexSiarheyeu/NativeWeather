//
//  WeatherStateCell.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/29/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class WeatherStateCell: UICollectionViewCell {

    @IBOutlet weak var weatherValueLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var separatorLine: UIView!
    
    weak var presenter: MainWeatherPresenterProtocol!
  
    func configure(row: Int) {
        weatherStateLabel.text = presenter.weatherStates[row].0
        weatherValueLabel.text = presenter.weatherStates[row].1
        
        if row == 0 {
          
            separatorLine.isHidden = false
            weatherValueLabel.isHidden = true
            weatherStateLabel.font = .systemFont(ofSize: 18)
            weatherStateLabel.numberOfLines = 0
            
            weatherStateLabel.text = presenter.weatherStates[0].0
            
        }
    }
}
