//
//  UnixDateConverter.swift
//  NativeWeather
//
//  Created by Alexey Sergeev on 10/3/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import Foundation

 
class UnixDateConverter {
    
    enum DateFormat: String {
        case day = "EEEE"
        case hourAndMin = "h:mm a"
        case hour = "h a"
    }
    
    class func convert(unixDate: Int, withFormat: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat.rawValue
        let hour = unixDate
        let date = Date(timeIntervalSince1970: TimeInterval(hour))
        return dateFormatter.string(from: date)
    }
}
