//
//  WeatherRepositoryMock.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//
import Foundation

final class WeatherRepositoryMock: WeatherRepository {
    
    func fetchCurrentWeather(for information: ForecastInformation) async throws -> Weather {
        if let response = getCurrentWeather() {
            return response
        } else {
            throw CustomErrors.mockError
        }
    }
    
    func fetchForecast(for information: ForecastInformation) async throws -> Forecast {
        if let response = getForecast() {
            return response
        } else {
            throw CustomErrors.mockError
        }
    }
    
    func getCoordinates(for city: String) async throws -> [Coordinates] {
        if let response = getCoordinates() {
            return response
        } else {
            throw CustomErrors.mockError
        }
    }
}

// MARK: - Data
private extension WeatherRepositoryMock {
    func getCurrentWeather() -> Weather? {
        let responseString = """
        {
            "coord": {
                "lon": -56.1674,
                "lat": -34.8335
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 91.42,
                "feels_like": 94.06,
                "temp_min": 91.42,
                "temp_max": 92.91,
                "pressure": 1011,
                "humidity": 43,
                "sea_level": 1011,
                "grnd_level": 1008
            },
            "visibility": 10000,
            "wind": {
                "speed": 8.05,
                "deg": 330
            },
            "clouds": {
                "all": 0
            },
            "dt": 1739049851,
            "sys": {
                "type": 1,
                "id": 8687,
                "country": "UY",
                "sunrise": 1739005920,
                "sunset": 1739054748
            },
            "timezone": -10800,
            "id": 3441575,
            "name": "Pocitos",
            "cod": 200
        }
        """
        return try? responseString.decode(toObject: Weather.self)
    }
    
    func getForecast() -> Forecast? {
        let responseString = """
        {
            "cod": "200",
            "message": 0,
            "cnt": 40,
            "list": [
                {
                    "dt": 1739415600,
                    "main": {
                        "temp": 291.73,
                        "feels_like": 291.81,
                        "temp_min": 291.73,
                        "temp_max": 291.73,
                        "pressure": 1017,
                        "sea_level": 1017,
                        "grnd_level": 1014,
                        "humidity": 83,
                        "temp_kf": 0
                    },
                    "weather": [
                        {
                            "id": 804,
                            "main": "Clouds",
                            "description": "overcast clouds",
                            "icon": "04n"
                        }
                    ],
                    "clouds": {
                        "all": 100
                    },
                    "wind": {
                        "speed": 3.5,
                        "deg": 55,
                        "gust": 7.3
                    },
                    "visibility": 10000,
                    "pop": 0,
                    "sys": {
                        "pod": "n"
                    },
                    "dt_txt": "2025-02-10 03:00:00"
                },
                {
                    "dt": 1739426400,
                    "main": {
                        "temp": 290.53,
                        "feels_like": 290.52,
                        "temp_min": 290.53,
                        "temp_max": 290.53,
                        "pressure": 1017,
                        "sea_level": 1017,
                        "grnd_level": 1014,
                        "humidity": 84,
                        "temp_kf": 0
                    },
                    "weather": [
                        {
                            "id": 804,
                            "main": "Clouds",
                            "description": "overcast clouds",
                            "icon": "04n"
                        }
                    ],
                    "clouds": {
                        "all": 100
                    },
                    "wind": {
                        "speed": 3.86,
                        "deg": 41,
                        "gust": 8.65
                    },
                    "visibility": 10000,
                    "pop": 0,
                    "sys": {
                        "pod": "n"
                    },
                    "dt_txt": "2025-02-10 06:00:00"
                },
                {
                    "dt": 1739437200,
                    "main": {
                        "temp": 289.7,
                        "feels_like": 289.68,
                        "temp_min": 289.7,
                        "temp_max": 289.7,
                        "pressure": 1017,
                        "sea_level": 1017,
                        "grnd_level": 1014,
                        "humidity": 87,
                        "temp_kf": 0
                    },
                    "weather": [
                        {
                            "id": 801,
                            "main": "Clouds",
                            "description": "few clouds",
                            "icon": "02n"
                        }
                    ],
                    "clouds": {
                        "all": 16
                    },
                    "wind": {
                        "speed": 3.19,
                        "deg": 35,
                        "gust": 8.21
                    },
                    "visibility": 10000,
                    "pop": 0,
                    "sys": {
                        "pod": "n"
                    },
                    "dt_txt": "2025-02-10 09:00:00"
                },
                {
                    "dt": 1739448000,
                    "main": {
                        "temp": 294.15,
                        "feels_like": 293.95,
                        "temp_min": 294.15,
                        "temp_max": 294.15,
                        "pressure": 1018,
                        "sea_level": 1018,
                        "grnd_level": 1015,
                        "humidity": 63,
                        "temp_kf": 0
                    },
                    "weather": [
                        {
                            "id": 800,
                            "main": "Clear",
                            "description": "clear sky",
                            "icon": "01d"
                        }
                    ],
                    "clouds": {
                        "all": 8
                    },
                    "wind": {
                        "speed": 3.46,
                        "deg": 42,
                        "gust": 5.36
                    },
                    "visibility": 10000,
                    "pop": 0,
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2025-02-10 12:00:00"
                },
                {
                    "dt": 1739458800,
                    "main": {
                        "temp": 300.64,
                        "feels_like": 300.33,
                        "temp_min": 300.64,
                        "temp_max": 300.64,
                        "pressure": 1017,
                        "sea_level": 1017,
                        "grnd_level": 1014,
                        "humidity": 39,
                        "temp_kf": 0
                    },
                    "weather": [
                        {
                            "id": 800,
                            "main": "Clear",
                            "description": "clear sky",
                            "icon": "01d"
                        }
                    ],
                    "clouds": {
                        "all": 0
                    },
                    "wind": {
                        "speed": 2.4,
                        "deg": 103,
                        "gust": 4.1
                    },
                    "visibility": 10000,
                    "pop": 0,
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2025-02-10 15:00:00"
                },
                {
                    "dt": 1739469600,
                    "main": {
                        "temp": 300.05,
                        "feels_like": 300.47,
                        "temp_min": 300.05,
                        "temp_max": 300.05,
                        "pressure": 1015,
                        "sea_level": 1015,
                        "grnd_level": 1013,
                        "humidity": 50,
                        "temp_kf": 0
                    },
                    "weather": [
                        {
                            "id": 800,
                            "main": "Clear",
                            "description": "clear sky",
                            "icon": "01d"
                        }
                    ],
                    "clouds": {
                        "all": 0
                    },
                    "wind": {
                        "speed": 7,
                        "deg": 120,
                        "gust": 6.32
                    },
                    "visibility": 10000,
                    "pop": 0,
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2025-02-10 18:00:00"
                }
            ],
            "city": {
                "id": 3441575,
                "name": "Montevideo",
                "coord": {
                    "lat": -34.8335,
                    "lon": -56.1674
                },
                "country": "UY",
                "population": 1270737,
                "timezone": -10800,
                "sunrise": 1739005920,
                "sunset": 1739054748
            }
        }
        """
        return try? responseString.decode(toObject: Forecast.self)
    }
    
    func getCoordinates() -> [Coordinates]? {
        let responseString = """
        [
            {
                "name": "Buenos Aires",
                "local_names": {
                    "uz": "Buenos Ayres",
                    "oc": "Buenos Aires",
                    "my": "ဗျူနိုအေးရိစ်မြို့",
                    "ht": "Bwènozè",
                    "es": "Buenos Aires",
                    "en": "Buenos Aires",
                    "ku": "Buenos Aires",
                    "he": "בואנוס איירס",
                    "sv": "Buenos Aires",
                    "gl": "Bos Aires",
                    "la": "Bonaëropolis",
                    "pl": "Buenos Aires",
                    "mr": "बुएनोस आइरेस",
                    "ug": "Buénos Ayrés",
                    "mk": "Буенос Аирес",
                    "ka": "ბუენოს-აირესი",
                    "ru": "Буэнос-Айрес",
                    "et": "Buenos Aires",
                    "ta": "புவெனஸ் ஐரிஸ்",
                    "th": "บัวโนสไอเรส",
                    "tk": "Buenos-Aýres",
                    "lv": "Buenosairesa",
                    "bg": "Буенос Айрес",
                    "lt": "Buenos Airės",
                    "ar": "بوينس آيرس",
                    "tr": "Buenos Aires",
                    "de": "Buenos Aires",
                    "gr": "Εὐαερόπολις",
                    "ce": "Буэнос-Айрес",
                    "hy": "Բուենոս Այրես",
                    "ml": "ബ്യൂണസ് ഐറീസ്",
                    "yi": "בוענאס איירעס",
                    "hu": "Buenos Aires",
                    "tg": "Буэнос Айрес",
                    "tl": "Lungsod ng Buenos Aires",
                    "el": "Μπουένος Άιρες",
                    "eo": "Bonaero",
                    "bn": "বুয়েনোস আইরেস",
                    "is": "Búenos Aíres",
                    "bo": "པུ་ཨེ་ནོ་སི་ཨས་རི་སི།",
                    "ba": "Буэнос-Айрес",
                    "fr": "Buenos Aires",
                    "zh": "布宜诺斯艾利斯",
                    "ko": "부에노스아이레스",
                    "be": "Буэнас-Айрэс",
                    "uk": "Буенос-Айрес",
                    "sr": "Буенос Ајрес",
                    "ky": "Буэнос-Айрес",
                    "hi": "ब्यूनस आयर्स",
                    "az": "Buenos Ayres",
                    "ab": "Буенос-Аирес",
                    "am": "ብዌኖስ አይሬስ",
                    "nb": "Buenos Aires",
                    "fa": "بوئنوس آیرس",
                    "ja": "ブエノスアイレス",
                    "mn": "Буэнос-Айрес",
                    "os": "Буэнос-Айрес",
                    "kn": "ಬ್ವೇನೊಸ್ ಐರೇಸ್",
                    "ur": "بیونس آئرس"
                },
                "lat": -34.6075682,
                "lon": -58.4370894,
                "country": "AR"
            }
        ]
        """
        return try? responseString.decode(toObject: [Coordinates].self)
    }
}
