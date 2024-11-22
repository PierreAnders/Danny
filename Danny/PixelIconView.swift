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
        ],
        "fox": [
            [.clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .black, .brown, .brown, .white, .brown, .brown, .brown, .brown, .brown, .brown, .white, .brown, .brown, .black, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .black, .black, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .black, .black, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .black, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .black, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .black, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .black, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .black, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .brown, .brown, .brown, .black, .black, .white, .white, .white, .white, .white, .white, .white, .black, .black, .brown, .brown, .brown, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .white, .white, .white, .brown, .brown, .brown, .black, .white, .white, .black, .black, .white, .white, .white, .white, .black, .white, .white, .black, .brown, .brown, .brown, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
            [.clear, .white, .white, .brown, .brown, .brown, .brown, .brown, .black, .black, .black, .black, .black, .white, .white, .white, .white, .black, .black, .black, .black, .brown, .brown, .brown, .brown, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
            [.clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
            [.clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .black, .black, .black, .black, .black, .black, .black, .black, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .black, .black, .black, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .brown, .brown, .white, .white, .brown, .brown, .brown, .brown, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .clear, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear],
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
