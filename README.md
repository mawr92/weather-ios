# Weather App

Welcome to **Weather App**, a SwiftUI application that will allow you to get current weather information for your location, as well as Montevideo, Buenos Aires, and London.

## Features

- **Current Weather display**
- **5-Day every 3-Hours Forecast**
- **Offline Mode with Caching**
- **User-Friendly Interface**
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
| <img src="https://github.com/user-attachments/assets/c648b971-3ee4-4721-9ae7-52b74f407328" alt="Home Dark Mode" width="300"> | <img src="https://github.com/user-attachments/assets/f8ec02ba-07be-45b1-a1a7-6a253a91dcc3" alt="Home Light Mode" width="300"> |
| <img src="https://github.com/user-attachments/assets/ac29fe16-aa76-484e-937f-080ec7e825b3" alt="Detail Dark Mode" width="300"> | <img src="https://github.com/user-attachments/assets/36ea5842-7a48-4eb1-9db3-fa1e6d861ecb" alt="Detail Light Mode" width="300"> |

## Getting Started

1. Clone the app
2. Run the app from Xcode

## Future Improvements
1. Support for other platforms (watchOS, iPadOS, macOS)
2. Widgets development to see the forecast from the Home Screen
3. Search and add other Locations
4. Improve animations
