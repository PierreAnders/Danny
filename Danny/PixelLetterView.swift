//
//  PixelLetterView.swift
//  Chakras
//
//  Created by Pierre Untas on 09/11/2024.
//

import SwiftUI

struct PixelLetterView: View {
    let pixelSize: CGFloat = 2.5
    let spacing: CGFloat = 0.5
    
    let alphabet: [Character: [[Color]]] = [
        " ": [[.clear],
            [.clear],
            [.clear],
            [.clear],
            [.clear]
        ],
        "A": [
            [.clear, .white, .clear],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "B": [
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .white, .clear]
        ],
        "C": [
            [.clear, .white, .white],
            [.white, .clear, .clear],
            [.white, .clear, .clear],
            [.white, .clear, .clear],
            [.clear, .white, .white]
        ],
        "D": [
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .clear]
        ],
        "E": [
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .white, .clear],
            [.white, .clear, .clear],
            [.white, .white, .white]
        ],
        "F": [
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .white, .clear],
            [.white, .clear, .clear],
            [.white, .clear, .clear]
        ],
        "G": [
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .white]
        ],
        "H": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "I": [
            [.white, .white, .white],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.white, .white, .white]
        ],
        "J": [
            [.white, .white, .white],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.white, .white, .clear]
        ],
        "K": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "L": [
            [.white, .clear, .clear],
            [.white, .clear, .clear],
            [.white, .clear, .clear],
            [.white, .clear, .clear],
            [.white, .white, .white]
        ],
        "M": [
            [.white, .clear, .white],
            [.white, .white, .white],
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "N": [
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "O": [
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .white]
        ],
        "P": [
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .clear, .clear]
        ],
        "Q": [
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.clear, .clear, .white]
        ],
        "R": [
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .white, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "S": [
            [.clear, .white, .white],
            [.white, .clear, .clear],
            [.clear, .white, .clear],
            [.clear, .clear, .white],
            [.white, .white, .clear]
        ],
        "T": [
            [.white, .white, .white],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear]
        ],
        "U": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .white]
        ],
        "V": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.clear, .white, .clear]
        ],
        "W": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.white, .white, .white],
            [.white, .clear, .white]
        ],
        "X": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.clear, .white, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white]
        ],
        "Y": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear]
        ],
        "Z": [
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.clear, .white, .clear],
            [.white, .clear, .clear],
            [.white, .white, .white]
        ],
        "1": [
            [.clear, .white, .clear],
            [.white, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear],
            [.clear, .white, .clear]
        ],
        "2": [
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .white, .white]
        ],
        "3": [
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.clear, .white, .white],
            [.clear, .clear, .white],
            [.white, .white, .white]
        ],
        "4": [
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.clear, .clear, .white]
        ],
        "5": [
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.white, .white, .white]
        ],
        "6": [
            [.white, .white, .white],
            [.white, .clear, .clear],
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .white, .white]
        ],
        "7": [
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.clear, .clear, .white],
            [.clear, .clear, .white],
            [.clear, .clear, .white]
        ],
        "8": [
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .white, .white]
        ],
        "9": [
            [.white, .white, .white],
            [.white, .clear, .white],
            [.white, .white, .white],
            [.clear, .clear, .white],
            [.white, .white, .white]
        ],
        "0": [
            [.clear, .white, .clear],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.white, .clear, .white],
            [.clear, .white, .clear]
        ],
        "^": [
            [.clear, .white, .white, .white, .clear, .clear, .white, .white, .white, .clear],
            [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white],

            [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
            [.clear, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
            [.clear, .clear, .white, .white, .white, .white, .white, .white, .clear, .clear],
            [.clear, .clear, .clear, .white, .white, .white, .white, .clear, .clear, .clear],
            [.clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear],
        ],
        "*": [
            [.clear, .clear, .clear, .clear, .clear, .white],
            [.clear, .clear, .clear, .clear, .white, .clear],
            [.clear, .clear, .clear, .white, .white, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .white, .white, .white, .clear, .clear],
            [.white, .white, .white, .white, .white, .white],
            [.clear, .clear, .white, .white, .white, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .clear, .white, .white, .clear, .clear],
            [.clear, .white, .white, .clear, .clear, .clear],
            [.clear, .white, .clear, .clear, .clear, .clear],
            [.white, .clear, .clear, .clear, .clear, .clear],
        ]
    ]
    
    let text: String
    
    var primaryColor: Color = .white
    var backgroundColor: Color = .clear

        var body: some View {
            HStack(spacing: spacing) {
                ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                    if let pixels = alphabet[character] {
                        VStack(spacing: spacing) {
                            ForEach(0..<pixels.count, id: \.self) { row in
                                HStack(spacing: 0) {
                                    ForEach(0..<pixels[row].count, id: \.self) { col in
                                        Rectangle()
                                            .fill(pixels[row][col] == .white ? primaryColor : backgroundColor)
                                            .frame(width: pixelSize, height: pixelSize)
                                    }
                                }
                            }
                        }
                        .id(UUID())
                    }
                }
            }
        }
    }
