//
//  Weather.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

struct Weather: Codable {
    var date: Date?
    var summary: [Summary]
    var conditions: Conditions
    var visibility: Int
    var wind: Wind
    var sun: Sun
    
    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case summary = "weather"
        case conditions = "main"
        case visibility
        case wind
        case sun = "sys"
    }
    
    struct Summary: Codable {
        var category: String
        var description: String
        var icon: String
        
        enum CodingKeys: String, CodingKey {
            case category = "main"
            case description
            case icon
        }
        
        var iconPath: String {
            "\(Constants.baseUrl)/img/wn/\(icon)@4x.png"
        }
    }
    
    struct Conditions: Codable {
        var temperature: Double
        var feelsLike: Double
        var minTemperature: Double
        var maxTemperature: Double
        var pressure: Double
        var humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case feelsLike = "feels_like"
            case minTemperature = "temp_min"
            case maxTemperature = "temp_max"
            case pressure
            case humidity
        }
    }
    
    struct Wind: Codable {
        var speed: Double
        var degrees: Int
        
        enum CodingKeys: String, CodingKey {
            case speed
            case degrees = "deg"
        }
    }
    
    struct Sun: Codable {
        var sunrise: TimeInterval?
        var sunset: TimeInterval?
    }
}
