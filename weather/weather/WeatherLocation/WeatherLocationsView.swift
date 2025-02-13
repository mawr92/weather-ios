//
//  WeatherLocationsView.swift
//  weather
//
//  Created by Alejandra Wetsch on 11/2/25.
//

import SwiftUI

struct WeatherLocationsView: View {
    // MARK: - View Properties
    @Namespace private var namespace
    
    // MARK: - State Properties
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showWeatherDetail = false
    @State private var loading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if let location = viewModel.selectedLocation , showWeatherDetail {
                    WeatherDetailView(
                        weatherLocation: location,
                        namespace: namespace,
                        onClose: {
                            withAnimation(.easeInOut) {
                                showWeatherDetail = false
                            }
                        }
                    )
                    .zIndex(2)
                } else {
                    list
                }
            }
            .frame(maxHeight: .infinity)
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.large)
            .onReceive(viewModel.$selectedLocation, perform: { location in
                withAnimation(.easeInOut) {
                    showWeatherDetail = location != nil
                }
            })
            .onReceive(viewModel.$state) { state in
                handleState(state)
            }
        }
        
    }
}

// MARK: - SubViews
private extension WeatherLocationsView {
    @ViewBuilder
    var list: some View {
        if loading {
            VStack(spacing: 8) {
                LoadingView(size: 30)
                Text("Loading weather information. Please wait")
                    .font(.body)
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .center)
        } else {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(viewModel.weatherLocations, id: \.self) { location in
                        WeatherLocationCardView(
                            for: location,
                            namespace: namespace
                        )
                        .onTapGesture {
                            viewModel.setCurrentLocation(location)
                        }
                    }
                }
                .padding()
            }
            .zIndex(1)
        }
    }
}


// MARK: - Helpers
private extension WeatherLocationsView {
    func handleState(_ state: WeatherViewModel.State) {
        switch state {
        case .loading:
            loading = true
        case .didLoad:
            loading = false
        default:
            break
        }
    }
}

#Preview {
    WeatherLocationsView()
}
