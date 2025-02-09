//
//  WeatherRepositoryImpl.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//
import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    func fetchCurrentWeather(for information: ForecastInformation) async throws -> Weather {
        do {
            return try await ApiManager.shared.performRequest(from: .currentWeather(information: information))
        } catch let error {
            throw error
        }
    }
    
    func fetchForecast(for information: ForecastInformation) async throws -> Forecast {
        do {
            return try await ApiManager.shared.performRequest(from: .forecast(information: information))
        } catch let error {
            throw error
        }
    }
    
    func getCoordinates(for city: String) async throws -> [Coordinates] {
        do {
            return try await ApiManager.shared.performRequest(from: .geocoding(city: city))
        } catch let error {
            throw error
        }
    }
}
