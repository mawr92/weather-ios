//
//  LocationManagerFactory.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import Foundation

struct LocationManagerFactory {
    static func getLocationManger() -> LocationManagerProtocol {
        let isTesting = ProcessInfo.processInfo.testing
        let isPreviewing = ProcessInfo.processInfo.preview
        
        return isTesting || isPreviewing ? LocationManagerMock() : LocationManager()
    }
}
