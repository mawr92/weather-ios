//
//  weatherApp.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import SwiftUI

@main
struct weatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            WeatherLocationsView()
        }
    }
}
