//
//  WeatherDetailView.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import SwiftUI
import Combine

struct WeatherDetailView: View {
    // MARK: - View Properties
    var weatherLocation: WeatherLocation
    var namespace: Namespace.ID
    var onClose: () -> Void
    
    // MARK: - State Properties
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        VStack(spacing: 16) {
            header
                .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    sunrise
                        .padding(.horizontal)
                    if !weatherLocation.forecast.todayForecast.isEmpty {
                        todayForecast
                    }
                    
                    if !weatherLocation.forecast.futureForecast.isEmpty {
                        futureForecast
                            .padding(.horizontal)
                    }
                }
            }
        }
        .mask {
            RoundedRectangle(cornerRadius: 10)
                .matchedGeometryEffect(id: "mask\(weatherLocation.id)", in: namespace)
        }
        .navigationBarTitleDisplayMode(.inline)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    dragOffset = gesture.translation
                }
                .onEnded { gesture in
                    withAnimation {
                        onClose()
                    }
                    dragOffset = .zero
                }
        )
    }
}

// MARK: - Subviews
private extension WeatherDetailView {
    var header: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "location.north.circle")
                    .font(.headline)
                HStack(spacing: 4) {
                    Text(weatherLocation.name ?? "")
                        .font(.headline)
                        .underline()
                    Image(systemName: "chevron.down")
                        .font(.body)
                }
                .onTapGesture {
                    onClose()
                }
                Spacer()
                if weatherLocation.isCurrent {
                    Text("Current location")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            Text(weatherLocation.weather.conditions.formattedTemperature)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            Text(weatherLocation.weather.summary.first?.capitalizedDescription ?? "")
                .font(.headline)
            
            HStack(spacing: 8) {
                Text("H: \(weatherLocation.weather.conditions.formattedMaxTemperature)")
                    .font(.caption)
                Text("L: \(weatherLocation.weather.conditions.formattedMinTemperature)")
                    .font(.caption)
            }
            HStack(spacing: 8) {
                WeatherConditionView(
                    condition: .humidity,
                    value: weatherLocation.weather.conditions.formattedHumidity
                )
                WeatherConditionView(
                    condition: .realFeel,
                    value: weatherLocation.weather.conditions.formattedFeelsLike
                )
                WeatherConditionView(
                    condition: .pressure,
                    value: weatherLocation.weather.conditions.formattedPressure
                )
            }
        }
        .foregroundStyle(weatherLocation.weather.momentOfTheDay.foregroundColor)
        .padding(16)
        .background {
            BackgroundImage(
                image: weatherLocation.weather.momentOfTheDay.background,
                height: 220
            )
            .matchedGeometryEffect(id: "background\(weatherLocation.id)", in: namespace)
        }
        .mask(RoundedRectangle(cornerRadius: 10))
    }
    
    var sunrise: some View {
        HStack {
            SunInformationView(condition: .sunrise, value: weatherLocation.weather.sun.formattedSunrise)
            SeparatorView()
            SunInformationView(condition: .sunset, value: weatherLocation.weather.sun.formattedSunset)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
        .background(Material.thin)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
    
    var todayForecast: some View {
        VStack {
            Text("TODAY'S FORECAST")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(weatherLocation.forecast.todayForecast, id: \.self) { forecast in
                        ForecastView(weather: forecast, layout: .vertical)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var futureForecast: some View {
        VStack {
            Text("3-HOUR FORECAST")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 8) {
                ForEach(weatherLocation.forecast.futureForecast, id: \.self) { forecast in
                    ForecastView(weather: forecast, layout: .horizontal)
                }
            }
        }
    }
}
