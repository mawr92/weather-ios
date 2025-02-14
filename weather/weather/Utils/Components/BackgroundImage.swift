//
//  BackgroundImage.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct BackgroundImage: View {
    var image: Image
    var height: CGFloat?
    
    var body: some View {
        GeometryReader { geometry in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: height, alignment: .topLeading)
                .clipped()
        }
        
    }
}

#Preview {
    BackgroundImage(image: Image(.night), height: 100)
}
