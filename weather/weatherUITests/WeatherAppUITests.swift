//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import XCTest

final class WeatherAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var weatherAppActivities: WeatherAppActivities!
    private var weatherLocationsUI: WeatherLocationsUI!
    private var weatherDetailsUI: WeatherDetailUI!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        weatherLocationsUI = WeatherLocationsUI(app: app)
        weatherDetailsUI = WeatherDetailUI(app: app)
        weatherAppActivities = WeatherAppActivities(
            weatherLocationUI: weatherLocationsUI,
            weatherDetailUI: weatherDetailsUI
        )
        continueAfterFailure = false
        app.launchArguments.append("-testing")
        app.launchArguments.append("-reset")
    }
    
    override func tearDown() {
        weatherLocationsUI = nil
        app.launchArguments = []
        super.tearDown()
    }
    
    func testInitialLoad() {
        app.launch()
        weatherAppActivities.initialActivity()
    }
    
    func testDismissDetail() {
        app.launch()
        weatherAppActivities.dismissDetail()
    }
    
    func testTapLocation() {
        app.launch()
        weatherAppActivities.tapOnLocation()
    }
}
