//
//  WeatherUnit.swift
//  weather
//
//  Created by Alejandra Wetsch on 14/2/25.
//
import SwiftUI

enum WeatherUnit: String {
    case celsius = "metric"
    case fahrenheit = "imperial"
    
    var image: Image {
        switch self {
        case .celsius: Image(systemName: "degreesign.celsius")
        case .fahrenheit: Image(systemName: "degreesign.fahrenheit")
        }
    }
    
    mutating func toggle() {
        switch self {
        case .celsius:
            self = .fahrenheit
        case .fahrenheit:
            self = .celsius
        }
    }
}
