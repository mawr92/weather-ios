//
//  SunInformationView.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct SunInformationView: View {
    var condition: SunCondition
    var value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(condition.rawValue)
                .font(.headline)
                .frame(maxWidth: .infinity)
            HStack(spacing: 4) {
                condition.image
                    .foregroundStyle(condition.foregroundColor)
                Text(value)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Enum
extension SunInformationView {
    enum SunCondition: String {
        case sunrise = "Sunrise"
        case sunset = "Sunset"
        
        var image: Image {
            switch self {
            case .sunrise: Image(systemName: "sunrise")
            case .sunset: Image(systemName: "sunset")
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .sunrise: .yellow
            case .sunset: .gray
            }
        }
    }
}

#Preview {
    SunInformationView(condition: .sunrise, value: "6:54 PM")
}
