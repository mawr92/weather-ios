//
//  WeatherRepository.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//
import Foundation

protocol WeatherRepository {
    func fetchCurrentWeather(for information: ForecastInformation) async throws -> Weather
    func fetchForecast(for information: ForecastInformation) async throws -> Forecast
    func getCoordinates(for city: String) async throws -> [Coordinates]
}
