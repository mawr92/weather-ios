//
//  WeatherLocation.swift
//  weather
//
//  Created by Alejandra Wetsch on 11/2/25.
//
import Foundation

struct WeatherLocation: Hashable, Equatable {
    let id = UUID()
    var name: String?
    var coordinates: Coordinates
    var weather: Weather
    var forecast: Forecast
    var isCurrent: Bool
}
