//
//  MomentOfTheDay.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

enum MomentOfTheDay: Hashable, Equatable {
    case day
    case night
    
    var background: Image {
        switch self {
        case .day: Image(.day)
        case .night: Image(.night)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .day: .black
        case .night: .white
        }
    }
}
