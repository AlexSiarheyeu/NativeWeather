//
//  HeaderHourlyForecastCell.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/29/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class HeaderHourlyForecastCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherStateImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    
    weak var presenter: MainWeatherPresenterProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(row: Int) {
        if row == 0 { timeLabel.text = "Now" }

        timeLabel.text = presenter.hourlyDay(row: row)
        temperatureLabel.text = presenter.hourlyTemperature(row: row)
        weatherStateImageView.image = presenter.hourlyWeatherStateImage(row: row)
    }
}
