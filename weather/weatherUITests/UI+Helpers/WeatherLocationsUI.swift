//
//  WeatherLocationsUI.swift
//  weather
//
//  Created by Alejandra Wetsch on 14/2/25.
//

import XCTest

final class WeatherLocationsUI {
    private var app: XCUIApplication!
    
    init(app: XCUIApplication) { self.app = app }
    
    // MARK: - General Elements
    var navigationBar: XCUIElement { app.navigationBars["Weather"] }
    var title: XCUIElement { app.staticTexts["Weather"] }
    var scroll: XCUIElement { app.scrollViews["weatherLocationScroll"] }
    var location: XCUIElement {
        app.otherElements.containing(.staticText, identifier: "locationCardLocationName-Montevideo").firstMatch
    }
    
    func assertScreenLayout() -> Bool {
        return navigationBar.exists && title.exists
    }
    
    func assertLocationList() -> Bool {
        return assertScreenLayout() && scroll.exists
    }
    
    func assertLocationListWithItems() -> Bool {
        return assertScreenLayout() && scroll.exists && location.exists
    }
}
