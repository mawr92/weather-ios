//
//  Coordinates.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

struct Coordinates: Codable, Hashable, Equatable {
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
