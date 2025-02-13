//
//  WeatherViewModel.swift
//  weather
//
//  Created by Alejandra Wetsch on 9/2/25.
//

import Foundation
import Combine
import CoreLocation

@MainActor
final class WeatherViewModel: ObservableObject {
    typealias WeatherAndForecast = (weather: Weather?, forecast: Forecast?)
    // MARK: - Private Properties
    private var repository: WeatherRepository?
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    private var currentLocation: Coordinates?
    
    // MARK: - Published Properties
    @Published var state: State = .idle
    @Published var weatherLocations = [WeatherLocation]()
    @Published var selectedLocation: WeatherLocation?
    
    // MARK: - Init
    init() {
        repository = WeatherRepositoryFactory.getRepository()
        setupLocationManagerBindings()
    }
}

// MARK: - Public Methods
extension WeatherViewModel {
    func loadInitialData() async {
        cleanup()
        state = .loading
            
        async let currentLocationWeather = loadCurrentLocationWeather()
        async let citiesWeather = loadCitiesWeather()
        
        var results = await [currentLocationWeather, citiesWeather].flatMap { $0 }
        results = results.sorted(by: {$0.isCurrent && !$1.isCurrent})
        
        DispatchQueue.main.async {
            self.weatherLocations = results
            self.setSelectedLocationIfNeeded()
            self.state = .didLoad
        }
    }
    
    func setCurrentLocation(_ location: WeatherLocation) {
        selectedLocation = location
        let locationDictionary = ["lat": location.coordinates.latitude, "lon": location.coordinates.longitude]
        UserDefaults.standard[.selectedLocation] = locationDictionary
    }
}
// MARK: - Private Methods
private extension WeatherViewModel {
    func cleanup() {
        weatherLocations.removeAll()
        cancellables.removeAll()
    }
    
    func setupLocationManagerBindings() {
        locationManager.currentLocation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let location, let self else { return }
                
                let coordinates = Coordinates(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
                self.currentLocation = coordinates
                Task {
                    await self.loadInitialData()
                }
            }
            .store(in: &cancellables)
        
        locationManager.locationAuthorizationStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.state = .loading
                switch status {
                case .authorized:
                    self?.locationManager.requestLocation()
                case .unauthorized:
                    Task {
                       await self?.loadInitialData()
                    }
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func setSelectedLocationIfNeeded() {
        if let selectedLocation = UserDefaults.standard[.selectedLocation],
           let lat = selectedLocation["lat"],
           let lon = selectedLocation["lon"] {
            
            let location = weatherLocations.first { $0.coordinates.latitude == lat && $0.coordinates.longitude == lon }
            self.selectedLocation = location
        } else {
            selectedLocation = weatherLocations.first { $0.isCurrent }
        }
    }
    
    func getForecastInformation(for coordinates: Coordinates?) -> ForecastInformation? {
        guard let coordinates else { return nil }
        
        return ForecastInformation(
            lat: String(describing: coordinates.latitude),
            long: String(describing: coordinates.longitude),
            unit: "metric"
        )
    }
    
    func loadCurrentLocationWeather() async -> [WeatherLocation] {
        guard let currentLocation else { return [] }

        if let (coordinates, weatherAndForecast) = await loadCityWeather(with: currentLocation) {
            if let location = transformToWeatherLocation(
                coordinates: coordinates,
                city: weatherAndForecast.weather?.name,
                weatherAndForecast: weatherAndForecast,
                isCurrent: true
            ) {
                return [location]
            }
        }
        
        return []
    }
    
    func loadCitiesWeather() async -> [WeatherLocation] {
        return await withTaskGroup(of: WeatherLocation?.self) { group in
            for city in Constants.locations {
                group.addTask { [weak self] in
                    if let coordinates = await self?.getCoordinates(for: city),
                       let (coordinates, weatherAndForecast) = await self?.loadCityWeather(with: coordinates),
                       let location = await self?.transformToWeatherLocation(
                           coordinates: coordinates,
                           city: city,
                           weatherAndForecast: weatherAndForecast,
                           isCurrent: false
                       ) {
                        return location
                    }
                    return nil
                }
            }
            
            var results: [WeatherLocation] = []
            for await result in group {
                if let location = result {
                    results.append(location)
                }
            }
            return results
        }
    }
    
    func loadCityWeather(with coordinates: Coordinates) async -> (Coordinates, WeatherAndForecast)? {
        guard let info = self.getForecastInformation(for: coordinates) else { return nil }

        async let weather = self.loadWeather(for: info)
        async let forecast = self.loadForecast(for: info)

        return (coordinates, WeatherAndForecast(weather: await weather, forecast: await forecast))
    }
    
    func getCoordinates(for city: String) async -> Coordinates? {
        do {
            let coordinates = try await repository?.getCoordinates(for: city) ?? []
            return coordinates.first
        } catch {
            print("Error fetching coordinates: \(error)")
            return nil
        }
    }
    
    func loadWeather(for information: ForecastInformation) async -> Weather? {
        do {
            return try await repository?.fetchCurrentWeather(for: information)
        } catch {
            print("ERROR FETCHING WEATHER: \(error)")
            return nil
        }
    }

    func loadForecast(for information: ForecastInformation) async -> Forecast? {
        do {
            return try await repository?.fetchForecast(for: information)
        } catch {
            print("ERROR FETCHING FORECAST: \(error)")
            return nil
        }
    }
    
    func transformToWeatherLocation(coordinates: Coordinates, city: String?, weatherAndForecast: WeatherAndForecast, isCurrent: Bool) -> WeatherLocation? {
        guard let weather = weatherAndForecast.weather,
              let forecast = weatherAndForecast.forecast
        else { return nil }

        return WeatherLocation(
            name: city,
            coordinates: coordinates,
            weather: weather,
            forecast: forecast,
            isCurrent: isCurrent
        )
    }
}

// MARK: - State Enum
extension WeatherViewModel {
    enum State {
        case idle
        case didLoad
        case loading
    }
}
