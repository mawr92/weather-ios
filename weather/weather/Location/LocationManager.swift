//
//  LocationManager.swift
//  weather
//
//  Created by Alejandra Wetsch on 9/2/25.
//
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, LocationManagerProtocol, ObservableObject {
    
    // MARK: - Private Properties
    private var locationManager: CLLocationManager!
    
    // MARK: - Public Properties
    var currentLocation = PassthroughSubject<CLLocation?, Never>()
    var locationAuthorizationStatus = PassthroughSubject<LocationAuthorizationStatus?, Never>()
    
    // MARK: - Init
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = .leastNormalMagnitude
    }
}

// MARK: - Public Methods
extension LocationManager {
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate Methods
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation.send(locations.first)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task {
            switch manager.authorizationStatus {
            case .restricted, .denied:
                locationAuthorizationStatus.send(.unauthorized)
            case .notDetermined:
                locationAuthorizationStatus.send(.notDetermined)
            default:
                locationAuthorizationStatus.send(.authorized)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Did fail with error: \(error.localizedDescription)")
    }
}
