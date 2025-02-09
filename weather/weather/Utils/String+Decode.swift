//
//  String+Decode.swift
//  weather
//
//  Created by Alejandra Wetsch on 8/2/25.
//

import Foundation

extension String {
    func decode<T: Decodable>(toObject object: T.Type) throws -> T? {
        
        let jsonData = self.data(using: .utf8)
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(object.self, from: jsonData!)
        } catch {
            throw error
        }
    }
}
