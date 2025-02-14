//
//  UserDefaults.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import Foundation

extension UserDefaults {
    struct Key<Value> {
        var name: String
    }
    
    subscript<T>(key: Key<T>) -> T? {
        get {
            return value(forKey: key.name) as? T
        }
        set {
            setValue(newValue, forKey: key.name)
        }
    }
    
    static func removeAllKeys() {
        standard[.cacheDate] = nil
        standard[.selectedLocation] = nil
    }
}

extension UserDefaults.Key {
    static var cacheDate: UserDefaults.Key<Date> {
        return .init(name: "cacheDate")
    }
    
    static var selectedLocation: UserDefaults.Key<[String: Double]> {
        return .init(name: "selectedLocation")
    }
}
