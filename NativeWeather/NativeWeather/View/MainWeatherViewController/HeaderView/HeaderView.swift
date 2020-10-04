//
//  HeaderView.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/29/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
   
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dayMinTemperature: UILabel!
    @IBOutlet weak var dayMaxTemperature: UILabel!
    
    @IBOutlet weak var hourlyForecastCollectionView: UICollectionView!
    
    var presenter: MainWeatherPresenterProtocol! {
        didSet{
            cityLabel.text = presenter.cityName
            temperatureLabel.text = presenter.temperature
            weekDayLabel.text = presenter.presentDay
            weatherStateLabel.text = presenter.weatherDescription
            dayMaxTemperature.text = presenter.maxTemperature
            dayMinTemperature.text = presenter.minTemperature
            hourlyForecastCollectionView.reloadData()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        
        hourlyForecastCollectionView.showsHorizontalScrollIndicator = false
        hourlyForecastCollectionView.dataSource = self
        hourlyForecastCollectionView.delegate = self
        hourlyForecastCollectionView.register(UINib(nibName: "HeaderHourlyForecastCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
}


