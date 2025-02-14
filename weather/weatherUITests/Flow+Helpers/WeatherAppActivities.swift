//
//  WeatherAppActivities.swift
//  weather
//
//  Created by Alejandra Wetsch on 14/2/25.
//

import Foundation
import XCTest

final class WeatherAppActivities {
    var weatherLocationUI: WeatherLocationsUI
    var weatherDetailUI: WeatherDetailUI
    
    init(weatherLocationUI: WeatherLocationsUI, weatherDetailUI: WeatherDetailUI) {
        self.weatherLocationUI = weatherLocationUI
        self.weatherDetailUI = weatherDetailUI
    }
    
    func initialActivity() {
        XCTContext.runActivity(named: "Initial Load") { activity in
            if weatherLocationUI.navigationBar.waitForExistence(timeout: 2) {
                XCTAssert(weatherLocationUI.assertScreenLayout())
                if weatherDetailUI.locationName.waitForExistence(timeout: 2) {
                    XCTAssert(weatherDetailUI.assertCurrentLocationHeader())
                    XCTAssert(weatherDetailUI.assertWeatherDetailScreen())
                } else {
                    XCTFail("Weather Detail View not found")
                }
            } else {
                XCTFail("Weather Location not found")
            }
        }
    }
    
    func dismissDetail() {
        XCTContext.runActivity(named: "Dismiss detail") { activity in
            initialActivity()
            weatherDetailUI.locationName.tap()
            if weatherLocationUI.location.waitForExistence(timeout: 2) {
                XCTAssert(weatherLocationUI.assertLocationListWithItems())
            } else {
                XCTFail("Didn't return to main view")
            }
        }
    }
    
    func tapOnLocation() {
        XCTContext.runActivity(named: "Tap on Location") { activity in
            dismissDetail()
            weatherLocationUI.location.tap()
            if weatherDetailUI.locationName.waitForExistence(timeout: 2) {
                XCTAssert(weatherDetailUI.assertWeatherDetailScreen())
            } else {
                XCTFail("Failed to find detail")
            }
        }
    }
}
