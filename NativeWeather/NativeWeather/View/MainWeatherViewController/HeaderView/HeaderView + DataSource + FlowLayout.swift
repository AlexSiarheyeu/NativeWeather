//
//  HeaderView + DataSource + FlowLayout.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/4/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit


extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 10 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HeaderHourlyForecastCell
        
        cell.presenter = presenter
        cell.configure(row: indexPath.row)
        return cell
    }
}

extension HeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 70, height: collectionView.frame.height)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}
