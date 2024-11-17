//
//  PixelIconview.swift
//  Chakras
//
//  Created by Pierre Untas on 11/11/2024.
//

import SwiftUI

struct PixelIconView: View {
    let pixelSize: CGFloat = 2.5
    let spacing: CGFloat = 0.5
    
    let icons: [String: [[Color]]] = [
        "heart": [
            [.clear, .white, .white, .white, .clear, .clear, .white, .white, .white, .clear],
            [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white],

            [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear],
            [.clear, .clear, .clear, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear],
        ],
        "lightning": [
            [.clear, .clear, .clear, .clear, .white, .clear],
            [.clear, .clear, .clear, .white, .clear, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .white, .white, .clear, .clear, .clear],
            [.white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .white, .white, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .clear, .white, .clear, .clear, .clear],
            [.clear, .white, .clear, .clear, .clear, .clear],
        ],
        "hand": [
            [.clear, .clear, .white, .clear, .white, .white, .clear, .white, .clear],
            [.white, .clear, .white, .clear, .white, .white, .clear, .white, .clear],
            [.white, .clear, .white, .clear, .white, .white, .clear, .white, .clear],
            [.white, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .clear],
            [.white, .white, .white, .clear, .white, .white, .white, .white, .white],
            [.white, .white, .white, .clear, .clear, .clear, .clear, .white, .white],
            [.white, .white, .white, .white, .white, .clear, .white, .white, .white],
            [.clear, .white, .white, .white, .clear, .white, .white, .white, .clear],
            [.clear, .clear, .white, .white, .white, .white, .white, .clear, .clear],
        ],
        "book": [
            [.clear, .white, .white, .white, .white, .white, .clear, .white, .white, .white, .white, .white, .clear],
            [.white, .clear, .clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .white],
            [.white, .clear, .white, .white, .white, .white, .clear, .white, .white, .white, .white, .clear, .white],
            [.white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white],
            [.white, .clear, .white, .white, .white, .white, .clear, .white, .white, .white, .white, .clear, .white],
            [.white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white],
            [.white, .clear, .white, .white, .white, .white, .clear, .white, .white, .white, .white, .clear, .white],
            [.white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white],
            [.clear, .white, .white, .white, .white, .white, .clear, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear],
        ],
        "boot": [
            [.clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.white, .white, .white, .white, .white, .clear, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .white, .white, .white, .white, .clear, .white, .white, .clear, .clear, .clear],
            [.clear, .white, .white, .white, .white, .white, .clear, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .white, .white, .white, .white, .white, .clear, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear],
            [.clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .white, .white, .clear, .clear, .white, .white, .white, .white, .white],
        ],
        "arrow": [
            [.clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear],
            [.clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear],
            [.clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear],
            [.white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .white, .clear, .clear, .clear],
        ]
    ]
    
let iconName: String
    var primaryColor: Color = .white
    var backgroundColor: Color = .clear
    
    var body: some View {
        VStack(spacing: spacing) {
            if let pixels = icons[iconName] {
                ForEach(0..<pixels.count, id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(0..<pixels[row].count, id: \.self) { col in
                            Rectangle()
                                .fill(pixels[row][col] == .white ? primaryColor : backgroundColor)
                                .frame(width: pixelSize, height: pixelSize)
                        }
                    }
                }
            } else {
                Text("Icône non trouvée")
                    .foregroundColor(.red)
            }
        }
    }
}
