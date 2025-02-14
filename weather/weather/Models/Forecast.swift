//
//  Forecast.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

struct Forecast: Codable, Hashable, Equatable {
    var list: [Weather]
    
    var todayForecast: [Weather] {
        return list.filter({$0.date?.isToday() == true})
    }
    
    var futureForecast: [Weather] {
        return list.filter({$0.date?.isToday() == false})
    }
}
