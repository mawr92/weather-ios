//
//  CachedAsyncImage.swift
//  weather
//
//  Created by Alejandra Wetsch on 13/2/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    var url: URL?
    var size: CGSize
    @State private var imageData: Data?
    
    var body: some View {
        Group {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .frame(width: size.width, height: size.height, alignment: .center)
        .task {
            imageData = await ApiManager.shared.performDataRequest(from: url)
        }
    }
}

#Preview {
    CachedAsyncImage(
        url: URL(string: "https://openweathermap.org/img/wn/10d@4x.png"),
        size: .init(width: 50, height: 50)
    )
}
