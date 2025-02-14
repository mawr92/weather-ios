//
//  LocationManagerMock.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import Foundation
import CoreLocation
import Combine

class LocationManagerMock: LocationManagerProtocol {
    var currentLocation = PassthroughSubject<CLLocation?, Never>()
    var locationAuthorizationStatus = PassthroughSubject<LocationAuthorizationStatus?, Never>()
    private(set) var currentAuthorizationStatus: LocationAuthorizationStatus = .authorized
    
    func requestLocation() {
        let location = CLLocation(latitude: 37.334606, longitude: -122.009102)
        currentLocation.send(location)
    }
    
    func requestAuthorization() {
        locationAuthorizationStatus.send(currentAuthorizationStatus)
    }
    
    func setLocationAuthorization(for status: LocationAuthorizationStatus) {
        currentAuthorizationStatus = status
    }
}
