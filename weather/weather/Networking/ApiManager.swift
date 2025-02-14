//
//  NetworkManager.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

final class ApiManager {
    // MARK: - Public Properties
    static let shared = ApiManager()
    
    // MARK: - Typealias
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    // MARK: - Private Properties
    private var session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    private var baseUrl = Constants.baseUrl
    private var cacheExpiryAfter: TimeInterval = 300
    
    // MARK: - Initializer
    private init() {
        configure()
    }
}

// MARK: - Public Methods
extension ApiManager {
    func performRequest<D: Decodable>(from endpoint: ApiEndpoints) async throws -> D {
        let request = try createRequest(from: endpoint, baseUrl)
        if let data: D = try getCachedData(for: request) {
            return data
        } else {
            return try await getServerData(request)
        }
    }
    
    @discardableResult
    func performDataRequest(from url: URL?) async -> Data? {
        guard let url else { return nil }
        
        let request = URLRequest(url: url)
        
        if let data: Data = try? getCachedData(for: request) {
            return data
        } else {
            return await getData(for: request)
        }
    }
}

// MARK: - Request Helpers
private extension ApiManager {
    func createRequest(from endpoint: ApiEndpoints, _ baseURL: String?) throws -> URLRequest {
        guard
            let baseURL = baseURL,
            let urlPath = URL(string: baseURL.appending(endpoint.path)),
            var urlComponents = URLComponents(string: urlPath.absoluteString)
        else {
            throw CustomErrors.invalidPath
        }
        
        urlComponents.queryItems = endpoint.queryParameters
        let apiKey = URLQueryItem(name: "appId", value: "7374274fe644fca85e96ae4fcacaf41e")
        urlComponents.queryItems?.append(apiKey)
        
        var request = URLRequest(url: urlComponents.url ?? urlPath)
        request.httpMethod = endpoint.method.rawValue
        request.cachePolicy = .returnCacheDataElseLoad
        
        return request
    }
    
    func getServerData<D: Decodable>(_ request: URLRequest) async throws -> D {
        do {
            let response: NetworkResponse = try await session.data(for: request)
            let decodedData = try decoder.decode(D.self, from: response.data)
            cacheData(with: response, request: request, keepData: false)
            
            return decodedData
        } catch {
            throw error
        }
    }
    
    func getData(for request: URLRequest) async -> Data? {
        do {
            let response: NetworkResponse = try await session.data(for: request)
            cacheData(with: response, request: request)
            return response.data
        } catch {
            return nil
        }
    }
}

// MARK: - Cache
private extension ApiManager {
    func cacheData(with response: NetworkResponse, request: URLRequest, keepData: Bool = true) {
        let cachedResponse = CachedURLResponse(response: response.response, data: response.data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        
        if keepData {
            UserDefaults.standard[.cacheDate] = Date()
        }
    }
    
    func shouldRemoveCache(for request: URLRequest) -> Bool {
        guard let cacheDate = UserDefaults.standard[.cacheDate]
        else { return false }
        
        if Date().timeIntervalSince(cacheDate) > cacheExpiryAfter {
            URLCache.shared.removeCachedResponse(for: request)
            UserDefaults.standard[.cacheDate] = nil
            return true
        }
        
        return false
    }
    
    func getCachedData<D: Decodable>(for request: URLRequest) throws -> D? {
        if shouldRemoveCache(for: request) {
            return nil
        } else {
            do {
                if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                    let decodedData = try decoder.decode(D.self, from: cachedResponse.data)
                    return decodedData
                } else {
                    return nil
                }
            } catch {
                throw error
            }
        }
    }
}

// MARK: - Configuration
private extension ApiManager {
    func configure() {
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.date(from: dateString) ?? .now
        })
    }
}
