//
//  Double+Utils.swift
//  weather
//
//  Created by Alejandra Wetsch on 10/2/25.
//

import Foundation

extension Double {
    func toDegreesString() -> String {        
        return "\(String(describing: Int(self)))°"
    }
    
    func toPercentageString() -> String {
        return "\(String(describing: Int(self)))%"
    }
}
