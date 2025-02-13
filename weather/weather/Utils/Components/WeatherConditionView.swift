//
//  WeatherConditionView.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct WeatherConditionView: View {
    var condition: WeatherCondition
    var value: String
    
    var body: some View {
        HStack {
            condition.image
                .font(.body)
            Text(value)
                .font(.body)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Enum
extension WeatherConditionView {
    enum WeatherCondition {
        case humidity
        case pressure
        case realFeel
        
        var image: Image {
            switch self {
            case .humidity: Image(systemName: "humidity.fill")
            case .pressure: Image(systemName: "barometer")
            case .realFeel: Image(systemName: "thermometer.low")
            }
        }
    }
}


#Preview {
    WeatherConditionView(condition: .humidity, value: "81%")
}
