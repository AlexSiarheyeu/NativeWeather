//
//  MainWeatherFlowLayout + Delegate.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/3/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

extension MainWeatherViewController: UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
        headerView.presenter = presenter
        
        return headerView
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0: return .init(width: view.frame.width, height: 320)
        case 1: return CGSize.zero
        default:
            break
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            
            return .init(width: collectionView.frame.width, height: 40)

        } else if indexPath.section == 1 {
           
            return .init(width: collectionView.frame.width, height: 60)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 1 {
            return .init(top: 20, left: 0, bottom: 0, right: 0)
        }
        return .zero
    }
}

