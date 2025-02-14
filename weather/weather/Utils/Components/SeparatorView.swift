//
//  SeparatorView.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct SeparatorView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(width: 1)
            .padding(.top, 2)
    }
}

#Preview {
    SeparatorView()
}
