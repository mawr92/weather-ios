//
//  LocationManagerProtocol.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//
import Foundation
import Combine
import CoreLocation

protocol LocationManagerProtocol {
    var currentLocation: PassthroughSubject<CLLocation?, Never>{ get set }
    var locationAuthorizationStatus: PassthroughSubject<LocationAuthorizationStatus?, Never> { get set}
    func requestAuthorization()
    func requestLocation()
}


