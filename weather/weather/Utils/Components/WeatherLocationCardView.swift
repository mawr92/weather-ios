//
//  WeatherLocationCardView.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct WeatherLocationCardView: View {
    // MARK: - View Properties
    var location: WeatherLocation
    var namespace: Namespace.ID
    
    init(for location: WeatherLocation, namespace: Namespace.ID) {
        self.location = location
        self.namespace = namespace
    }
    
    var body: some View {
        HStack(spacing: 8) {
            if let url = location.weather.summary.first?.iconPath {
                CachedAsyncImage(url: url, size: .init(width: 50, height: 50))
                    .accessibilityIdentifier("\(UITestIdentifiers.locationCardIcon)-\(location.name ?? "")")
            }
            VStack(alignment: .leading) {
                if let name = location.name {
                    Text(name)
                        .font(.title3)
                        .accessibilityIdentifier("\(UITestIdentifiers.locationCardLocationName)-\(name)")
                }
                
                if location.isCurrent {
                    Text("Current Location")
                        .font(.caption)
                }
                Spacer()
                Text(location.weather.summary.first?.capitalizedDescription ?? "")
                    .font(.footnote)
                    .accessibilityIdentifier("\(UITestIdentifiers.locationCardDescription)-\(location.name ?? "")")
            }
            VStack(alignment: .trailing) {
                Text(location.weather.conditions.formattedTemperature)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .accessibilityIdentifier("\(UITestIdentifiers.locationCardTemperature)-\(location.name ?? "")")
                Spacer()
                HStack {
                    Text("H: \(location.weather.conditions.formattedMaxTemperature)")
                        .font(.caption)
                        .accessibilityIdentifier("\(UITestIdentifiers.locationCardMaxTemperature)-\(location.name ?? "")")
                    Text("L: \(location.weather.conditions.formattedMinTemperature)")
                        .font(.caption)
                        .accessibilityIdentifier("\(UITestIdentifiers.locationCardMinTemperature)-\(location.name ?? "")")
                }
            }
        }
        .foregroundStyle(location.weather.momentOfTheDay.foregroundColor)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background {
            BackgroundImage(
                image: location.weather.momentOfTheDay.background,
                height: 100
            )
            .matchedGeometryEffect(id: "background\(location.id)", in: namespace)
        }
        .mask {
            RoundedRectangle(cornerRadius: 10)
                .matchedGeometryEffect(id: "mask\(location.id)", in: namespace)
        }
    }
}
