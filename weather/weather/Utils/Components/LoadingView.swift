//
//  LoadingView.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct LoadingView: View {
    // MARK: - State Properties
    @State private var rotationAngle = 0.0
    
    // MARK: - View Properties
    var size: CGFloat
    var colors: [Color] = [.clear, .accentColor]
    private var lineWidth: CGFloat {
        return size / 10
    }
    
    var body: some View {
        ZStack(
            alignment: .center
        ) {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundStyle(.white.opacity(0.2))
                .frame(width: size, height: size)
            Circle()
                .trim(from: 0, to: 0.6)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(1),
                        endAngle: .degrees(270)
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(rotationAngle))
        }
        .onAppear {
            withAnimation(.linear(duration: 1.5)
                .repeatForever(autoreverses: false)) {
                    rotationAngle = 360.0
                }
        }
    }
}

#Preview {
    LoadingView(size: 40)
}
