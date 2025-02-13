//
//  ForecastView.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct ForecastView: View {
    var weather: Weather
    var layout: Layout
    
    var body: some View {
        switch layout {
        case .horizontal:
            horizontal
        case .vertical:
            vertical
        }
    }
}

// MARK: - Subviews
private extension ForecastView {
    var vertical: some View {
        VStack {
            Text(weather.time)
                .font(.headline)
                .frame(maxWidth: .infinity)
            if let url = weather.summary.first?.iconPath {
                CachedAsyncImage(url: url, size: .init(width: 30, height: 30))
            }
            Text(weather.conditions.formattedTemperature)
                .font(.title2)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
        .frame(width: 80)
        .background(Material.thin)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
    
    var horizontal: some View {
        HStack {
            VStack {
                Text(String(describing: weather.day))
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(String(describing: weather.time))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text(weather.conditions.formattedTemperature)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .center)
            if let url = weather.summary.first?.iconPath {
                CachedAsyncImage(url: url, size: .init(width: 50, height: 50))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Material.thin)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Enum
extension ForecastView {
    enum Layout {
        case vertical
        case horizontal
    }
}
