//
//  Weather.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

struct Weather: Codable, Hashable, Equatable {
    var date: Date?
    var summary: [Summary]
    var conditions: Conditions
    var visibility: Int
    var wind: Wind
    var sun: Sun
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case summary = "weather"
        case conditions = "main"
        case visibility
        case wind
        case sun = "sys"
        case name
    }
    
    var time: String {
        date?.formatted(.dateTime.hour()) ?? ""
    }
    
    var day: String {
        date?.formatted(.dateTime.weekday(.wide)).localizedCapitalized ?? ""
    }
    
    var momentOfTheDay: MomentOfTheDay {
        return summary.first?.icon.contains("n") == true ? .night : .day
    }
    
    struct Summary: Codable, Hashable, Equatable {
        var category: String
        var description: String
        var icon: String
        
        enum CodingKeys: String, CodingKey {
            case category = "main"
            case description
            case icon
        }
        
        var iconPath: URL? {
            URL(string: "\(Constants.iconUrl)/img/wn/\(icon)@4x.png")
        }
        
        var capitalizedDescription: String {
            description.capitalized
        }
    }
    
    struct Conditions: Codable, Hashable, Equatable {
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
        
        var formattedHumidity: String {
            humidity.toPercentageString()
        }
        
        var formattedTemperature: String {
            temperature.toDegreesString()
        }
        
        var formattedMaxTemperature: String {
            maxTemperature.toDegreesString()
        }
        
        var formattedMinTemperature: String {
            minTemperature.toDegreesString()
        }
        
        var formattedFeelsLike: String {
            feelsLike.toDegreesString()
        }
        
        var formattedPressure: String {
            "\(Int(pressure)) hPa"
        }
    }
    
    struct Wind: Codable, Hashable, Equatable {
        var speed: Double
        var degrees: Int
        
        enum CodingKeys: String, CodingKey {
            case speed
            case degrees = "deg"
        }
    }
    
    struct Sun: Codable, Hashable, Equatable {
        var sunrise: TimeInterval?
        var sunset: TimeInterval?
        
        var formattedSunrise: String {
            guard let sunrise else { return "" }
            return Date(timeIntervalSince1970: sunrise).formatted(.dateTime.hour())
        }
        
        var formattedSunset: String {
            guard let sunset else { return "" }
            return Date(timeIntervalSince1970: sunset).formatted(.dateTime.hour())
        }
    }
}
