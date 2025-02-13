//
//  Date+Utils.swift
//  weather
//
//  Created by Alejandra Wetsch on 10/2/25.
//

import Foundation

extension Date {
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: Date())
    }
    
    func getComponents(components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
}

