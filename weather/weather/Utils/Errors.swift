//
//  Errors.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

enum CustomErrors: Error {
    case invalidPath
    case unknown
    case mockError
    
    var description: String {
        switch self {
        case .invalidPath: "Invalid API Path"
        case .unknown: "Unknown Error"
        case .mockError: "Mock Error"
        }
    }
}
