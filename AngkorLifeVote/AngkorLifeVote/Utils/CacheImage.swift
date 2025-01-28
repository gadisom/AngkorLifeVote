//
//  CacheImage.swift
//  AngkorLifeVote
//
//  Created by 김정원 on 1/28/25.
//

import SwiftUI

struct CacheImage: View {
    @StateObject private var imageLoader: ImageLoader
    
    let cornerRadius: CGFloat

    init(url: String, cornerRadius: CGFloat = 8) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        ZStack {
            if let uiImage = imageLoader.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                ProgressView()
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 상위에서 width, height 지정
    }
}

