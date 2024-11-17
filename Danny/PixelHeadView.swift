import SwiftUI

struct PixelHeadView: View {
    let pixelSize: CGFloat = 2
    let totalWidth: CGFloat = 200
    
    // Liste de frames pour l'animation
    let frame: [[Color]] =
    [
        [.clear, .clear, .clear, .clear, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .brown, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .brown, .black, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .black, .brown, .brown, .white, .brown, .brown, .brown, .brown, .brown, .brown, .white, .brown, .brown, .black, .black, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .black, .black, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .black, .black, .black, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .black, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .black, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .black, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .black, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .black, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .black, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .brown, .brown, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .brown, .brown, .brown, .black, .black, .white, .white, .white, .white, .white, .white, .white, .black, .black, .brown, .brown, .brown, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .white, .white, .white, .brown, .brown, .brown, .black, .white, .white, .black, .black, .white, .white, .white, .white, .black, .white, .white, .black, .brown, .brown, .brown, .brown, .white, .white, .clear, .clear],
        [.clear, .white, .white, .brown, .brown, .brown, .brown, .brown, .black, .black, .black, .black, .black, .white, .white, .white, .white, .black, .black, .black, .black, .brown, .brown, .brown, .brown, .brown, .white, .white, .clear],
        [.clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear],
        [.clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear],
        [.clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .black, .black, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear],
        [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear]
    ]
    
    var body: some View {
        VStack {
            PixelHeadGrid(colors: frame, pixelSize: pixelSize)
        }
    }
    
    struct PixelHeadGrid: View {
        let colors: [[Color]]
        let pixelSize: CGFloat
        
        var body: some View {
            VStack(spacing: 0.5) {
                ForEach(0..<colors.count, id: \.self) { rowIndex in
                    HStack(spacing: 0.5) {
                        ForEach(0..<colors[rowIndex].count, id: \.self) { colIndex in
                            Rectangle()
                                .fill(colors[rowIndex][colIndex])
                                .frame(width: pixelSize, height: pixelSize)
                        }
                    }
                }
            }
        }
    }
    
    struct PixelHeadView_Previews: PreviewProvider {
        static var previews: some View {
            PixelHeadView()
        }
    }
}
