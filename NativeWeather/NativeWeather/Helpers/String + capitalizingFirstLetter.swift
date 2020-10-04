//
//  String + capitalizedFirstLetter.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
