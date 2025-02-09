//
//  ProcessInfo+Utils.swift
//  weather
//
//  Created by Alejandra Wetsch on 9/2/25.
//

import Foundation

extension ProcessInfo {
    
    var testing: Bool {
        contains("-testing")
    }
    
    var preview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    private func contains(_ argument: String) -> Bool {
        arguments.contains(argument)
    }
}
