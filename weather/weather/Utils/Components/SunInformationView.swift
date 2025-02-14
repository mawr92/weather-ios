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
    var titleAccessibilityIdentifier: String
    var valueAccessibilityIdentifier: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(condition.description)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .accessibilityIdentifier(titleAccessibilityIdentifier)
            HStack(spacing: 4) {
                condition.image
                    .foregroundStyle(condition.foregroundColor)
                Text(value)
                    .frame(maxWidth: .infinity)
                    .accessibilityIdentifier(valueAccessibilityIdentifier)
            }
        }
    }
}

// MARK: - Enum
extension SunInformationView {
    enum SunCondition {
        case sunrise
        case sunset
        
        var description: String {
            switch self {
            case .sunrise:
                return NSLocalizedString("Sunrise", comment: "").localizedCapitalized
            case .sunset:
                return NSLocalizedString("Sunset", comment: "").localizedCapitalized
            }
        }
        
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
    SunInformationView(
        condition: .sunrise,
        value: "6:54 PM",
        titleAccessibilityIdentifier: "title",
        valueAccessibilityIdentifier: "value"
    )
}
