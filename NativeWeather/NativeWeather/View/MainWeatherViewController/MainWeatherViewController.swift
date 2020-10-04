//
//  MainWeatherViewController.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/29/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit


class MainWeatherViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MainWeatherPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isHidden = true
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "path")
        URLCache.shared = urlCache
        
        setupCollectionView()
        collectionView.contentInset = .init(top: 120, left: 0, bottom: 0, right: 0)
    }
    
    private func setupCollectionView() {
        
        collectionView.collectionViewLayout = MainWeatherFlowLayout()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: "DailyWeatherCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib(nibName: "WeatherStateCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell1")
        collectionView.register(UINib(nibName: "HeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
}
