//
//  Forecast.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

struct Forecast: Codable {
    var days: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case days = "list"
    }
}
