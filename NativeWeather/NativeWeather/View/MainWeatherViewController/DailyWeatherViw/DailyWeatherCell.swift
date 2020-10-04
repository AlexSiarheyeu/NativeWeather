//
//  DailyWeatherCell.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/29/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {

    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    
    weak var presenter: MainWeatherPresenterProtocol!

    func configure(row: Int) {
        weekDayLabel.text = presenter.dailyDay(row: row)
        weatherStateImageView.image = presenter.dailyWeatherStateImage(row: row)
        highTemperatureLabel.text = presenter.dailyHighTemperature(row: row)
        lowTemperatureLabel.text = presenter.dailyLowTemperature(row: row)
    }
}
