//
//  WeatherDetailUI.swift
//  weather
//
//  Created by Alejandra Wetsch on 14/2/25.
//

import XCTest

final class WeatherDetailUI {
    private var app: XCUIApplication!
    
    init(app: XCUIApplication) { self.app = app }
    
    // Header elements
    var locationIcon: XCUIElement { app.images["location.north.circle"] }
    var locationName: XCUIElement { app.staticTexts["weatherDetailLocationName"] }
    var currentLocation: XCUIElement { app.staticTexts["weatherDetailCurrentLocation"] }
    var temperature: XCUIElement { app.staticTexts["weatherDetailTemperature"] }
    var summary: XCUIElement { app.staticTexts["weatherDetailSummaryDescription"] }
    var maxTemperature: XCUIElement { app.staticTexts["weatherDetailMaxTemperature"] }
    var minTemperature: XCUIElement { app.staticTexts["weatherDetailMinTemperature"] }
    var humidityImage: XCUIElement { app.images["humidity.fill"] }
    var humidity: XCUIElement { app.staticTexts["weatherDetailHumidity"] }
    var realFeelImage: XCUIElement { app.images["thermometer.low"] }
    var realFeel: XCUIElement { app.staticTexts["weatherDetailRealFeel"] }
    var pressureImage: XCUIElement { app.images["barometer"] }
    var pressure: XCUIElement { app.staticTexts["weatherDetailPressure"] }
    
    // General elements
    var scroll: XCUIElement { app.scrollViews["weatherDetailScroll"] }
    
    // Sun elements
    var sunriseTitle: XCUIElement { app.staticTexts["weatherDetailSunriseTitle"] }
    var sunriseImage: XCUIElement { app.images["sunrise"] }
    var sunrise: XCUIElement { app.staticTexts["weatherDetailSunrise"] }
    var sunsetTitle: XCUIElement { app.staticTexts["weatherDetailSunsetTitle"] }
    var sunsetImage: XCUIElement { app.images["sunset"] }
    var sunset: XCUIElement { app.staticTexts["weatherDetailSunset"] }
    
    // Forecast elements
    var forecastTitle: XCUIElement { app.staticTexts["weatherDetailForecastTitle"] }
    var todayForecasteTitle: XCUIElement { app.staticTexts["weatherDetailTodayForecastTitle"] }
    
    func assertHeader() -> Bool {
        return locationIcon.exists &&
        locationName.exists &&
        temperature.exists &&
        summary.exists &&
        maxTemperature.exists &&
        minTemperature.exists &&
        humidityImage.exists &&
        humidity.exists &&
        realFeelImage.exists &&
        realFeel.exists &&
        pressureImage.exists &&
        pressure.exists
    }
    
    func assertCurrentLocationHeader() -> Bool {
        return assertHeader() &&
        currentLocation.exists
    }
    
    func assertSunConditions() -> Bool {
        return sunriseTitle.exists &&
        sunriseImage.exists &&
        sunrise.exists &&
        sunsetTitle.exists &&
        sunsetImage.exists &&
        sunset.exists
    }
    
    func assertWeatherDetailScreen() -> Bool {
        return assertHeader() &&
        scroll.exists &&
        assertSunConditions() &&
        forecastTitle.exists &&
        todayForecasteTitle.exists
    }
}
