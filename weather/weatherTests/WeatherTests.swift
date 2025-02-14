//
//  WeatherTests.swift
//  weatherTests
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation
import Testing
import Combine
@testable import weather

@MainActor
final class WeatherTests {
    private var viewModel: WeatherViewModel!
    private var cancellables: Set<AnyCancellable>
    
    init() {
        viewModel = WeatherViewModel()
        cancellables = []
    }
    
    deinit {
        UserDefaults.removeAllKeys()
        viewModel = nil
        cancellables.removeAll()
    }
    
    @Test("Test initial state of ViewModel")
    func testInitialState() async throws {
        #expect(viewModel.state == .idle)
        #expect(viewModel.weatherLocations.isEmpty)
        #expect(viewModel.selectedLocation == nil)
    }
    
    @Test("Test ViewModel States")
    func testInitialLoadStates() async throws {
        let expectedStates: [WeatherViewModel.State] = [
            .didAuthorizeLocation,
            .didFindLocation,
            .loading,
            .didLoad
        ]
        var receivedStates = [WeatherViewModel.State]()
        let stateTask = Task {
            for await state in viewModel.$state.values {
                receivedStates.append(state)
                if state == .didLoad {
                    break
                }
            }
        }
        
        viewModel.requestAuthorization()
        await stateTask.value
        
        #expect(receivedStates == expectedStates)
    }
    
    @Test("Test Data Loaded with Current Location")
    func testCompleteDataLoaded() async throws {
        
        let stateTask = Task {
            for await state in viewModel.$state.values {
                if state == .didLoad {
                    break
                }
            }
        }
        
        viewModel.requestAuthorization()
        await stateTask.value
        
        #expect(viewModel.weatherLocations.count == 4)
        #expect(viewModel.weatherLocations.contains(where: {$0.name == "Montevideo"}))
        #expect(viewModel.weatherLocations.contains(where: {$0.name == "London"}))
        #expect(viewModel.weatherLocations.contains(where: {$0.name == "Buenos Aires"}))
        #expect(viewModel.weatherLocations.contains(where: {
            ($0.coordinates.latitude == 37.334606 && $0.isCurrent)
        }))
        if let selectedLocation = viewModel.weatherLocations.first(where: {$0.isCurrent}) {
            #expect(viewModel.selectedLocation == selectedLocation)
        } else {
            Issue.record("No current location found")
        }
    }
    
    @Test("Test Data Loaded without Current Location")
    func testLocationDataLoaded() async throws {
        
        let stateTask = Task {
            for await state in viewModel.$state.values {
                if state == .didLoad {
                    break
                }
            }
        }
        
        await viewModel.loadInitialData()
        await stateTask.value
        
        #expect(viewModel.weatherLocations.count == 3)
        #expect(viewModel.weatherLocations.contains(where: {$0.name == "Montevideo"}))
        #expect(viewModel.weatherLocations.contains(where: {$0.name == "London"}))
        #expect(viewModel.weatherLocations.contains(where: {$0.name == "Buenos Aires"}))
        #expect(viewModel.selectedLocation == nil)
    }
    
    @Test("Test Selected Location Event")
    func testSetLocation() async throws {
        
        let stateTask = Task {
            for await state in viewModel.$state.values {
                if state == .didLoad {
                    break
                }
            }
        }
        
        await viewModel.loadInitialData()
        await stateTask.value
        
        #expect(!viewModel.weatherLocations.isEmpty)
        if let location = viewModel.weatherLocations.first {
            viewModel.setCurrentLocation(location)
            
            let coordinates = ["lat": location.coordinates.latitude, "lon": location.coordinates.longitude]
            
            #expect(viewModel.selectedLocation == location)
            #expect(UserDefaults.standard[.selectedLocation] != nil)
            #expect(UserDefaults.standard[.selectedLocation] == coordinates)
        } else {
            Issue.record("No location found")
        }
    }
}
