//
//  WeatherRepositoryFactory.swift
//  weather
//
//  Created by Alejandra Wetsch on 9/2/25.
//

import Foundation

struct WeatherRepositoryFactory {
    static func getRepository() -> WeatherRepository {
        let isTesting = ProcessInfo.processInfo.testing
        let isPreviewing = ProcessInfo.processInfo.preview
        
        return isTesting || isPreviewing ? WeatherRepositoryMock() : WeatherRepositoryImpl()
    }
}
