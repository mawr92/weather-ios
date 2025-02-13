//
//  AppDelegate.swift
//  weather
//
//  Created by Alejandra Wetsch on 12/2/25.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupCache()
        return true
    }
}

// MARK: - Helpers
private extension AppDelegate {
    func setupCache() {
        let memoryCapacity = 20 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        URLCache.shared.memoryCapacity = memoryCapacity
        URLCache.shared.diskCapacity = diskCapacity
    }
}
