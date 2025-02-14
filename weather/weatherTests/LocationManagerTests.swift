//
//  LocationManagerTests.swift
//  weatherTests
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import Foundation
import Testing
import Combine
import CoreLocation
@testable import Thunder_Forecast_App

final class LocationManagerTests {
    private var locationManager: LocationManagerMock!
    private var cancellables: Set<AnyCancellable>
    
    init() {
        locationManager = LocationManagerMock()
        cancellables = []
    }
    
    deinit {
        locationManager = nil
        cancellables.removeAll()
    }

    @Test("Expect Authorization Status to be correctly sent")
    func testAuthorization() async throws {
        locationManager.setLocationAuthorization(for: .authorized)
        locationManager.requestAuthorization()
        locationManager.locationAuthorizationStatus
            .receive(on: DispatchQueue.main)
            .sink { status in
                #expect(status == .authorized)
            }
            .store(in: &cancellables)
    }
    
    @Test("Expect to receive a CLLocation")
    func testGetLocation() async throws {
        locationManager.requestLocation()
        locationManager.currentLocation
            .receive(on: DispatchQueue.main)
            .sink { location in
                guard let latitude = location?.coordinate.latitude,
                let longitude = location?.coordinate.longitude
                else {
                    Issue.record("No location set")
                    return
                }
                
                #expect(latitude == 37.334606)
                #expect(longitude == -122.009102)
            }
            .store(in: &cancellables)
    }

}
