# Weather App

Welcome to **Weather App**, a SwiftUI application that will allow you to get current weather information for your location, as well as Montevideo, Buenos Aires, and London.

## Features

- **Current Weather display**
- **5-Day every 3-Hours Forecast**
- **Offline Mode with Caching**
- **User-Friendly Interface**
- **Switch between Celsius and Fahrenheit**
- **Light/Dark Mode Support**
- **iOS 15 as Minimum Deployment Target**

## Architecture

WeatherApp is built using the **Model-View-ViewModel (MVVM)** architecture pattern. This approach promotes a clear separation of concerns, enhancing code maintainability and testability.

## Offline Mode with Caching

Offline mode was included by caching all the data that the app consumes. This feature allows users to access the most recently viewed weather data without an active internet connection, and avoiding those annoying loadings all over the place. The cache data is deleted evey 5 minutes.

## Testing

- **Unit Testing:** Using Apple's brand new Swift Testing Framework
- **UI Testing:** Implemented with XCTest to verify that the user interface behaves as expected.

## Screenshots
| Dark Mode | Light Mode |
| --------------- | --------------- |
| <img src="https://github.com/user-attachments/assets/c0439841-7f27-4fb6-88ff-e8694ca3981b" alt="Home Dark Mode" width="300"> | <img src="https://github.com/user-attachments/assets/dc70f92b-55d1-4c7d-9aae-6928b9eda431" alt="Home Light Mode" width="300"> |
| <img src="https://github.com/user-attachments/assets/2bb15662-85ff-4eb9-b534-d3387b4b0c1e" alt="Detail Dark Mode" width="300"> | <img src="https://github.com/user-attachments/assets/e528c154-2a07-48fa-9c2e-a4f79230569b" alt="Detail Light Mode" width="300"> |

## Getting Started

1. Clone the app
2. Run the app from Xcode

## Future Improvements
1. Support for other platforms (watchOS, iPadOS, macOS)
2. Widgets development to see the forecast from the Home Screen
3. Search and add other Locations
4. Improve animations
