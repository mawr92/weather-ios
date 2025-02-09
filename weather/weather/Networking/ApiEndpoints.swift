//
//  ApiEndpoints.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

protocol EndpointInformation {
    var endpoint: String { get }
    var category: String { get }
    var version: String { get }
    var method: ApiMethod { get }
    var queryParameters: [URLQueryItem] { get }
}

// MARK: - Typealias
typealias ForecastInformation = (lat: String, long: String, unit: String)

enum ApiEndpoints: EndpointInformation {
    case currentWeather(information: ForecastInformation)
    case forecast(information: ForecastInformation)
    case geocoding(city: String)
    
    var category: String {
        switch self {
        case .currentWeather, .forecast: "data"
        case .geocoding: "geo"
        }
    }
    
    var version: String {
        switch self {
        case .currentWeather, .forecast: "2.5"
        case .geocoding: "1.0"
        }
    }
    
    var endpoint: String {
        switch self {
        case .currentWeather: "weather"
        case .forecast: "forecast"
        case .geocoding: "direct"
        }
    }
    
    var method: ApiMethod {
        return .GET
    }
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case .currentWeather(let information):
            return getQueryParameters(from: information)
        case .forecast(let information):
            return getQueryParameters(from: information)
        case .geocoding(let city):
            let city = URLQueryItem(name: "q", value: city)
            return [city]
        }
    }
    
    var path: String {
        return "/\(category)/\(version)/\(endpoint)"
    }
    
    // MARK: - Helpers
    private func getQueryParameters(from information: ForecastInformation) -> [URLQueryItem] {
        let latitude = URLQueryItem(name: "lat", value: information.lat)
        let longitude = URLQueryItem(name: "lon", value: information.long)
        let unit = URLQueryItem(name: "units", value: information.unit)
        return [latitude, longitude, unit]
    }
}
