//
//  MainWeatherFlowLayout.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 9/30/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class MainWeatherFlowLayout: UICollectionViewFlowLayout {

    var attributes: [UICollectionViewLayoutAttributes] = []
        
    override func prepare() {
        super.prepare()
        
        attributes = []
        guard let collectionView = collectionView else { return }
        
        let numberOfSections = collectionView.numberOfSections
        for section in 0..<numberOfSections {
            let headerIndexPath = IndexPath(item: 0, section: section)
            if let headerAttribute = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: headerIndexPath) {
                attributes.append(headerAttribute)
            }
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            for item in 0..<numberOfItems {
                let indexPath = IndexPath(item: item, section: section)
                if let attribute = layoutAttributesForItem(at: indexPath) {
                    attributes.append(attribute)
                }
            }
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let offset = collectionView?.contentOffset ?? CGPoint.zero

        guard let topHeader = attributes.first else { return nil }
        
        let topHeaderDefaultSize = topHeader.frame.size
        let screenHeight = UIScreen.main.bounds.height
        topHeader.frame.size.height = max(0.38 * screenHeight,
                                          topHeaderDefaultSize.height - offset.y)
        topHeader.frame.origin.y = offset.y
        return attributes
    }
}
