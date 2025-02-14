# Weather App

Welcome to **Weather App**, a SwiftUI application that will allow you to get current weather information for your location, as well as Montevideo, Buenos Aires, and London.

## Features

- **Current Weather display**
- **5-Day every 3-Hours Forecast**
- **Offline Mode with Caching**
- **User-Friendly Interface**
- **Switch between Celsius and Fahrenheit**
- **Light/Dark Mode Support**
- **English/Spanish Support**
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
| <img src="https://github.com/user-attachments/assets/ab560a2b-370c-4f3c-a65c-c53a084295a7" alt="Home Dark Mode" width="300"> | <img src="https://github.com/user-attachments/assets/74783dc5-a620-4963-bcd6-292d3e1c22d3" alt="Home Light Mode" width="300"> |
| <img src="https://github.com/user-attachments/assets/34694c16-a3b6-4087-978a-8e7cf2ea90bb" alt="Detail Dark Mode" width="300"> | <img src="https://github.com/user-attachments/assets/9aa5866f-0d13-4e09-aa82-219065edcc5b" alt="Detail Light Mode" width="300"> |
| <img src="https://github.com/user-attachments/assets/e021e17d-5b90-4040-9a38-93c1fcd0bc15" alt="Home Localized" width="300"> | <img src="https://github.com/user-attachments/assets/c6b3dd87-e60e-4cb4-bc0b-78c88ff81a35" alt="Detail Localized" width="300"> |


## Getting Started

1. Clone the app
2. Run the app from Xcode

## Future Improvements
1. Support for other platforms (watchOS, iPadOS, macOS)
2. Widgets development to see the forecast from the Home Screen
3. Search to Add more Locations
4. Improve animations
5. Error management
